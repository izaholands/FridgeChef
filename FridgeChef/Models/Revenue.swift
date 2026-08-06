//
//  File.swift
//  FridgeChef
//
//  Created by Carlos Alexandre Dias Messias de Lima on 06/08/26.
//

import Foundation
import SwiftData

@Model
class Revenue{
    var id: UUID
    var title: String
    var time: String
    var desc: String
    var ingredients: [String]
    var steps: [String]
    
    init(id: UUID = UUID(), title: String, time: String, desc: String, ingredients: [String], steps: [String]) {
        self.id = id
        self.title = title
        self.time = time
        self.desc = desc
        self.ingredients = ingredients
        self.steps = steps
    }
}
