////
////  FoodTranslationService.swift
////  FridgeChef
////
////  Created by Maria Izabelle Holanda de Andrade on 05/08/26.
////
//
//import Foundation
//
//struct FoodTranslationService {
//    
//    static func translate(_ ingredient: String) -> String{
//        
//        let cleanedFood = ingredient
//            .lowercased()
//            .replacingOccurrences(of: "_", with: " ")
//            //.filter{ !$0.isWhitespace || $0 == " "}
//            .components(separatedBy: .whitespacesAndNewlines)
//            .joined(separator: " ")
//            .trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        let translations: [String: String] = [
//           "Bread": "Pão",
//           "Lemon": "Limão",
//           "Nestle_Nescau": "Nescau",
//           "Onion": "Cebola",
//           "Nutella": "Nutella",
//           "Orange_Juice": "Suco de Laranja",
//           "Cola_Cola": "Coca Cola",
//           "Milk_Carton": "Caixa de Leite",
//           "Sliced_Bread": "Pão de Forma",
//           "Mayonnaise": "Maionese",
//           "Ketchup": "Ketchup"
//       ]
//       
////       func translate(_ food: String) -> String {
////           let normalized = food.lowercased()
////           
////           return translations[normalized] ?? food.capitalized
////       }
//        return translations[cleanedFood] ?? ingredient.capitalized
//        
//    }
//     
//}

import Foundation

struct FoodTranslationService {
    
    static func translate(_ name: String) -> String {
        
        print("Original:", name)
        print("Debug:", String(reflecting: name))
        
        let normalized = name
                .replacingOccurrences(of: "_", with: " ")
                .replacingOccurrences(of: "\u{200B}", with: "")
                .replacingOccurrences(of: "\u{200C}", with: "")
                .replacingOccurrences(of: "\u{200D}", with: "")
                .replacingOccurrences(of: "\u{FEFF}", with: "")
                .components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
                .joined(separator: " ")
                .lowercased()

            print("Normalizado:", normalized)
        
        let translations: [String:String] = [
            
            // pães
            "bread": "Pão",
            "sliced bread": "Pão de forma",
            
            // bebidas
            "coca cola": "Coca Cola",
            "coca_cola": "Coca Cola",
            
            // molhos
            "mayonnaise": "Maionese",
            "ketchup": "Ketchup",
            
            // vegetais
            "onion": "Cebola",
            
            // frutas
            "lemon": "Limão",
            "lime": "Limão",
            
            "hazelnut spread": "Nutella",
            "chocolate spread": "Nutella",
            "Nutella": "Nutella",

            "cocoa powder": "Nescau",
            "chocolate powder": "Nescau",

            "milk": "Leite",
            "milk carton": "Leite",
            
            "orange juice": "Suco de laranja"
        ]
        
        
        return translations[normalized] ?? name
    }
}
