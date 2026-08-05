import SwiftUI
import PhotosUI
import Combine

class CameraViewModel: ObservableObject {
    @Published var selectedImages: [UIImage] = []
    
    // Para navegação
    @Published var navigationPath = NavigationPath()
    
    // Ingredientes (Mock para a tela final)
    @Published var ingredients: [String] = ["Ovos", "Tomate", "Queijo", "Espinafre", "Cebola"]
    
    func addImage(_ image: UIImage) {
        selectedImages.append(image)
    }
    
    func removeImage(at index: Int) {
        guard index >= 0 && index < selectedImages.count else { return }
        selectedImages.remove(at: index)
    }
    
    func removeIngredient(_ ingredient: String) {
        ingredients.removeAll { $0 == ingredient }
    }
    
    func addIngredient(_ ingredient: String) {
        let trimmed = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty && !ingredients.contains(trimmed) {
            ingredients.append(trimmed)
        }
    }
}

enum CameraNavigationRoute: Hashable {
    case review
    case analyzing
    case ingredients
    case recipeResult
}
