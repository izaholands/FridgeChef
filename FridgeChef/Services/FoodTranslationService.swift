import Foundation

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
            "coca cola": "Refrigerante",
            "coca_cola": "Refrigerante",
            
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
            
            "nescau": "Nescau",
            "cocoa powder": "Nescau",
            "chocolate powder": "Nescau",

            "milk": "Leite",
            "milk carton": "Leite",
            "powdered milk": "Leite em pó",
            
            "orange juice": "Suco de laranja",
            
            "cookie": "Biscoito",
            
            "tangerine": "Tangerina",
            
            "snack chips": "Salgadinho",
            
            "soft drink": "Refrigerante",
            
            "cake": "Bolo",
            
            "cheese": "Queijo",
            
            "butter": "Manteiga",
            
            "yogurt": "Iorgute",
            
            "cream cheese": "Requeijao",
            
            "coffee": "Café",
            
            "water": "Água"
        ]
        
        
        return translations[normalized] ?? name
    }
}
