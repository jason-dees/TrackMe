//
//  Recipe.swift
//  TrackMe
//
//  Created by Jason Dees on 12/12/22.
//

import Foundation


public struct Recipe { // A grouping of ingredients with quantity data
    public let name: String
    public let longDescription: String
    public let totalQuantity: Measurement
    public let ingredients: [Ingredient] // need Food+Amount
    
    public init(name: String, longDescription: String, totalQuantity: Measurement, ingredients: [Ingredient]) {
        self.name = name
        self.longDescription = longDescription
        self.totalQuantity = totalQuantity
        self.ingredients = ingredients
    }
}

extension Recipe {
    public var macros: Macronutrients {
        get {
            return self.ingredients.reduce(Macronutrients.zeroed(), {
                $0 + $1.macros
            })
        }
    }
}

public struct Ingredient {
    public let food: Food
    public let measurement: Measurement
    
    public init(food: Food, measurement: Measurement){
        self.food = food
        self.measurement = measurement
    }
    public var macros: Macronutrients {
        get {
            food.macros(for: measurement)
        }
    }
}
