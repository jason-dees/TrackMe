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

public struct Meal {
    public let name: String
    public let eaten: [Eaten]
    
    public init(name: String, eaten: [Eaten]) {
        self.name = name
        self.eaten = eaten
    }
}

extension Meal {
    public var macros: Macronutrients {
        get throws {
            return try self.eaten.reduce(Macronutrients.zeroed(), {
                try $0 + $1.macros
            })
        }
    }
}

public struct Eaten {
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

extension Eaten {
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
        get throws{
            if let recipe = self.recipe {
                return try recipe.macros
            }
            if let food = self.food {
                return try food.macros
            }
            throw FoodError.macrosNotFound
        }
    }
}
