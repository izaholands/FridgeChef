import SwiftUI
import PhotosUI
import Combine
import SwiftData

class CameraViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var navigationPath = NavigationPath()
    @Published var ingredients: [Ingredient] = []
    @Published var feedbackMessages: [String] = []
    @Published var isLoading = false
    @Published var generatedRecipe: Revenue?
    // recipes array removed as SwiftData handles this
    
    private let vision = VisionService()
    private let recipeService = MLXRecipeService()
    private let translator = FoodTranslationService()
    
    func addImage(_ image: UIImage) {
        selectedImage = image
    }
    
    func analyzeImages() async {
        isLoading = true
        defer { isLoading = false }
        
        ingredients.removeAll()
        feedbackMessages.removeAll()
        
        guard let image = selectedImage else {
            feedbackMessages.append("Nenhuma imagem selecionada.")
            return
        }
        
        do {
            let detectedNames = try await vision.detectObjects(in: image)
            
            if detectedNames.isEmpty {
                feedbackMessages.append("Nenhum alimento foi identificado na imagem.")
                return
            }
            
            for name in detectedNames {
                print("Detectado:", name)
                let translatedName = FoodTranslationService.translate(name)
                print("Traduzido:", translatedName)

                if !ingredients.contains(where: {
                    $0.name.lowercased() == translatedName.lowercased()
                }) {
                    ingredients.append(Ingredient(name: translatedName))
                }
            }
        } catch {
            feedbackMessages.append("Erro ao analisar a imagem.")
        }
    }
    
    func generateRecipe(context: ModelContext) async {
        let translatedIngredients = ingredients.map {
            Ingredient(
                name: FoodTranslationService.translate($0.name)
            )
        }
        
        print("Ingredientes enviados para a API MLX:")
        for ingredient in ingredients {
            print("Ingrediente:", ingredient.name)
        }

        do {
            let recipe = try await recipeService.generateRecipe(
                ingredients: translatedIngredients
            )

            generatedRecipe = recipe
            
            // salva no SwiftData
            context.insert(recipe)
            
            // Remove a tela de carregamento
            navigationPath.removeLast()

            // Abre a receita
            navigationPath.append(CameraNavigationRoute.recipeResult)

        } catch {
            print("Erro na geração da receita:", error)
            feedbackMessages.append("Não foi possível conectar ao servidor MLX. Verifique se a API está rodando e se o IP está correto.")
            navigationPath.removeLast()
        }
    }
    
    func removeImage() {
        selectedImage = nil
    }
    
    func removeIngredient(_ ingredient: Ingredient) {
        ingredients.removeAll { $0.id == ingredient.id }
    }
    
    func addIngredient(_ ingredient: String) {
        let trimmed = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else { return }
        guard !ingredients.contains(where: {
            $0.name.lowercased() == trimmed.lowercased()
        }) else { return }
        
        ingredients.append(Ingredient(name: trimmed))
    }
}

enum CameraNavigationRoute: Hashable {
    case review
    case analyzing
    case ingredients
    case generatingRecipe
    case recipeResult
}
