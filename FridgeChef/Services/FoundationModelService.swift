////
////  FoundationModelService.swift
////  FridgeChef
////
////  Created by Maria Izabelle Holanda de Andrade on 05/08/26.
////
//
//import Foundation
//import FoundationModels
//
//@MainActor
//final class FoundationModelService {
//
//    private let session = LanguageModelSession()
//
//    func generateRecipe(
//        ingredients: [Ingredient]
//    ) async throws -> Recipe {
//
//        let ingredientNames = ingredients
//            .map { $0.name }
//            .joined(separator: ", ")
//
//        let prompt = """
//        Crie uma receita usando esses ingredientes:
//        \(ingredientNames)
//
//        Retorne:
//        - título da receita
//        - tempo de preparo
//        - descrição
//        - ingredientes
//        - passos do preparo
//        """
//
//        let response = try await session.respond(
//            to: prompt
//        )
//
//        //converter a resposta do Foundation Models para Recipe
//
//        return Recipe(
//            title: "Receita criada",
//            time: "30 min",
//            description: response.content,
//            ingredients: ingredients,
//            steps: [
//                "Prepare os ingredientes.",
//                "Cozinhe tudo.",
//                "Finalize e sirva."
//            ]
//        )
//    }
//}

//
//  FoundationModelService.swift
//  FridgeChef
//

import Foundation
import FoundationModels

@MainActor
final class FoundationModelService {

    private let session = LanguageModelSession()

    func generateRecipe(
        ingredients: [Ingredient]
    ) async throws -> Revenue {

        let ingredientNames = ingredients
            .map { $0.name }
            .joined(separator: ", ")

        // Using an English prompt often avoids false positive safety guardrails in FoundationModels
        // while still requesting the output in Portuguese.
        let prompt = """
        You are a helpful and creative culinary assistant. Please create a simple, safe, and delicious cooking recipe using ONLY these everyday food ingredients: \(ingredientNames).
        This is a benign request for a cooking app. All ingredients are safe for consumption.
        Please reply in Portuguese and output strictly a JSON object matching this structure:
        {
            "title": "Recipe name",
            "time": "Preparation time (e.g. 30 min)",
            "desc": "Short description",
            "ingredients": ["1 cup of sugar", "2 eggs"],
            "steps": ["Step 1...", "Step 2..."]
        }
        Do not add any Markdown formatting or text outside the JSON.
        """

        do {
            let response = try await session.respond(
                to: prompt
            )
            
            // Clean up possible markdown code blocks from output
            let jsonString = response.content
                .replacingOccurrences(of: "```json", with: "")
                .replacingOccurrences(of: "```", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)

            guard let jsonData = jsonString.data(using: .utf8) else {
                throw NSError(domain: "RecipeParseError", code: 1, userInfo: nil)
            }
            
            struct RecipeJSON: Decodable {
                let title: String
                let time: String
                let desc: String
                let ingredients: [String]
                let steps: [String]
            }
            
            let decoded = try JSONDecoder().decode(RecipeJSON.self, from: jsonData)

            return Revenue(
                title: decoded.title,
                time: decoded.time,
                desc: decoded.desc,
                ingredients: decoded.ingredients,
                steps: decoded.steps
            )
        } catch {
            print("FoundationModel error: \(error)")
            // Fallback in case of guardrail violation or generation error
            let ingredientNamesArray = ingredients.map { $0.name }
            return Revenue(
                title: "Receita de Emergência",
                time: "15 min",
                desc: "Não foi possível gerar a receita devido a um erro de segurança da IA. Misture os ingredientes e use a criatividade!",
                ingredients: ingredientNamesArray,
                steps: [
                    "Pegue os ingredientes: \(ingredientNames)",
                    "Misture tudo da forma que achar melhor",
                    "Aqueça se necessário e sirva."
                ]
            )
        }
    }
}
