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
    public let food: Food? // Has various quantities, needs quantity used
    public let measurement: Measurement
    
    public init(recipe: Recipe, measurement: Measurement) {
        self.recipe = recipe
        self.food = nil
        self.measurement = measurement
    }
    
    public init(food: Food, measurement: Measurement){
        self.food = food
        self.recipe = nil
        self.measurement = measurement
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
            if let food = self.food{
                return food.macros(for: self.measurement)
            }
            if let recipe = self.recipe {
                let percentOfBase: Double = self.measurement.quantity / recipe.totalQuantity.quantity
                return recipe.macros * percentOfBase
            }
            
            return Macronutrients()
        }
    }
}

extension EatenFood {
    public init() {
        self.init(food: Food(), measurement: Measurement.defaultValue)
    }
}
