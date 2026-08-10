import Foundation

@MainActor
final class MLXRecipeService {
    
    // IMPORTANTE:
    // Se estiver rodando no Simulador, "http://127.0.0.1:8000/gerar-receita" funciona.
    // Se for testar no iPhone físico, mude para o IP do seu Mac na Wi-Fi (ex: "http://192.168.0.15:8000/gerar-receita")
    private let urlString = "http://10.49.53.76:8000/gerar-receita"
    
    struct RecipeRequest: Encodable {
        let ingredientes: [String]
    }
    
    struct RecipeResponse: Decodable {
        let title: String
        let time: String
        let desc: String
        let ingredients: [String]
        let steps: [String]
    }
    
    func generateRecipe(ingredients: [Ingredient]) async throws -> Revenue {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let ingredientNames = ingredients.map { $0.name }
        let payload = RecipeRequest(ingredientes: ingredientNames)
        
        request.httpBody = try JSONEncoder().encode(payload)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("MLX API retornou um erro")
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
        
        return Revenue(
            title: decoded.title,
            time: decoded.time,
            desc: decoded.desc,
            ingredients: decoded.ingredients,
            steps: decoded.steps
        )
    }
}
