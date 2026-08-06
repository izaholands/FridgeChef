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
    ) async throws -> Recipe {

        let ingredientNames = ingredients
            .map { $0.name }
            .joined(separator: ", ")

        // Using an English prompt often avoids false positive safety guardrails in FoundationModels
        // while still requesting the output in Portuguese.
        let prompt = """
        Create a simple cooking recipe using these ingredients: \(ingredientNames).
        Please reply in Portuguese.
        Include a recipe name, preparation time, description, and steps.
        """

        do {
            let response = try await session.respond(
                to: prompt
            )

            return Recipe(
                title: "Sua Receita Especial",
                time: "30 min",
                description: response.content,
                ingredients: ingredients,
                steps: [
                    "Prepare os ingredientes: \(ingredientNames).",
                    "Siga o modo de preparo gerado na descrição.",
                    "Sirva quente e aproveite."
                ]
            )
        } catch {
            print("FoundationModel error: \(error)")
            // Fallback in case of guardrail violation or generation error
            return Recipe(
                title: "Receita de Emergência",
                time: "15 min",
                description: "Não foi possível gerar a receita devido a um erro de segurança da IA. Misture os ingredientes e use a criatividade!",
                ingredients: ingredients,
                steps: [
                    "Pegue os ingredientes: \(ingredientNames)",
                    "Misture tudo da forma que achar melhor",
                    "Aqueça se necessário e sirva."
                ]
            )
        }
    }
}
