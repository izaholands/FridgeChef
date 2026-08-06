//
//  Ingredient.swift
//  FridgeChef
//
//  Created by Maria Izabelle Holanda de Andrade on 05/08/26.
//

import Foundation

struct Ingredient: Identifiable, Hashable {
    let id = UUID()
    let name: String
}
