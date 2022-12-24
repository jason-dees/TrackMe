//
//  EatenFood.swift
//  TrackMe
//
//  Created by Jason Dees on 12/12/22.
//

import Foundation

public struct EatenFood {
    public let id: UUID = UUID()
    public let recipe: Recipe? // Has total quantity made, needs quantity used
    public let food: Food? // Has quantity used
    
    public init(recipe: Recipe) {
        self.recipe = recipe
        self.food = nil
    }
    
    public init(food: Food){
        self.food = food
        self.recipe = nil
    }
}

extension EatenFood {
    public var name: String {
        if let recipe = self.recipe {
            return recipe.name
        }
        if let food = self.food {
            return food.name
        }
        
        return "Not found"
    }
    
    public var macros: Macronutrients {
        get {
            if let recipe = self.recipe {
                return recipe.macros
            }
            if let food = self.food {
                return food.macros
            }
            return Macronutrients.zeroed()
        }
    }
}

extension EatenFood {
    public init() {
        self.init(food: Food())
    }
}
