//
//  Recipe.swift
//  FridgeChef
//
//  Created by Maria Izabelle Holanda de Andrade on 05/08/26.
//

import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let time: String
    let description: String
    let ingredients: [Ingredient]
    let steps: [String]
}
