//
//  Meal.swift
//  TrackMe
//
//  Created by Jason Dees on 11/25/22.
//

import Foundation

// A meal consists of eaten food/recipes
public struct Day {
    public let date: Date
    public let meals: [Meal]
    public let calorieLimit: Int
    
    public init(date: Date, meals: [Meal], calorieLimit: Int) {
        self.date = date
        self.meals = meals
        self.calorieLimit = calorieLimit
    }
    
    public init() {
        self.init(date: Date.now, meals: [], calorieLimit: -1)
    }
}

extension Day {
    public var macros: Macronutrients {
        get throws {
            return try self.meals.reduce(Macronutrients.zeroed(), {
                try $0 + $1.macros
            })
        }
    }
}


