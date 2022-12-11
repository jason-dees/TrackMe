//
//  Food.swift
//  TrackMe
//
//  Created by Jason Dees on 11/24/22.
//

import Foundation

public struct Recipe { // A grouping of ingredients with quantity data
    public let name: String
    public let description: String
    public let totalQuantity: Measurement
    public let ingredients: [Food]
    
    public init(name: String, description: String, totalQuantity: Measurement, ingredients: [Food]) {
        self.name = name
        self.description = description
        self.totalQuantity = totalQuantity
        self.ingredients = ingredients
    }
}

extension Recipe {
    public var macros: Macronutrients {
        get throws {
            return try self.ingredients.reduce(Macronutrients.zeroed(), {
                try $0 + $1.macros
            })
        }
    }
}

public struct RecipeFood {
    public let recipe: Recipe
    public let amount: Measurement
    
    public init(recipe: Recipe, amount: Measurement) {
        self.recipe = recipe
        self.amount = amount
    }
}

extension RecipeFood {
    public var macros: Macronutrients {
        get throws {
            // sum ingredients macros
            let macros = try self.recipe.macros
            if self.amount != self.recipe.totalQuantity {
                throw FoodError.measurementMismatched
            }
            // divide amount into recipe.totalQuantity
            let percent = self.amount.quantity / self.recipe.totalQuantity.quantity
            return macros * percent
        }
    }
    
}


public struct Food { // A logged edible
    public let name: String
    public let edible: Edible // Do i want to copy the edible information? Just macros here
    public let measurement: Measurement
    
    public init(name: String, edible: Edible, measurement: Measurement) {
        self.name = name
        self.edible = edible
        self.measurement = measurement
    }
}

extension Food {
    public var macros: Macronutrients {
        get throws {
            guard let baseAmount = self.edible.amounts.first(where: {$0.measurement == self.measurement}) else {
                throw FoodError.measurementNotFound
            }
            let percentOfBase: Double = self.measurement.quantity / baseAmount.quantity
            return baseAmount.macros * percentOfBase
        }
    }
}

public struct Edible { // Item data
    public let name: String
    public let amounts: [Amount] // A measurements can have differing macro amounts
    
    public init(name: String, amounts: [Amount]) {
        self.name = name
        self.amounts = amounts
    }
}

public struct Amount {
    public let measurement: Measurement
    public let macros: Macronutrients
    
    public init(measurement: Measurement, macros: Macronutrients) {
        self.measurement = measurement
        self.macros = macros
    }
}

extension Amount {
    public var quantity: Double {
        self.measurement.quantity
    }
}

public enum Measurement { // macros have a measurement associated with them
    case cups(Double)
    case grams(Double)
    case each(Double)
    case liters(Double)
    case tbsp(Double)
    case tsp(Double)
}

extension Measurement { // a measurement has macros, macros don't have a measurement
    public var quantity: Double {
        switch self {
        case let .cups(amount):
            return amount
        case let .grams(amount):
            return amount
        case let .each(amount):
            return amount
        case let .liters(amount):
            return amount
        case let .tbsp(amount):
            return amount
        case let .tsp(amount):
            return amount
        }
    }
}

extension Measurement: Equatable {
    public static func ==(lhs: Measurement, rhs: Measurement) -> Bool {
        switch (lhs,rhs) {
        case (.cups, .cups):
            return true
        case (.grams, .grams):
            return true
        case (.each, .each):
            return true
        case (.liters, .liters):
            return true
        case (.tbsp, .tbsp):
            return true
        case (.tsp, .tsp):
            return true
        default:
            return false
        }
        
    }
}

public struct Macronutrients {
    public let protein: Double
    public let carbohydrates: Double
    public let fat: Double
    public let calories: Double
    
    public init(protein: Double, carbohydrates: Double, fat: Double, calories: Double) {
        self.protein = protein
        self.carbohydrates = carbohydrates
        self.fat = fat
        self.calories = calories
    }
}
extension Macronutrients: Equatable {
    public static func ==(lhs: Macronutrients, rhs: Macronutrients) -> Bool {
        return lhs.protein == rhs.protein
        && lhs.carbohydrates == rhs.carbohydrates
        && lhs.fat == rhs.fat
        && lhs.calories == rhs.calories
    }
    
    public static func *(lhs: Macronutrients, rhs: Double) -> Macronutrients {
        Macronutrients(protein: lhs.protein * rhs,
                       carbohydrates: lhs.carbohydrates * rhs,
                       fat: lhs.fat * rhs,
                       calories: lhs.calories * rhs)
    }
    
    public static func +(lhs: Macronutrients, rhs: Macronutrients) -> Macronutrients {
        Macronutrients(protein: lhs.protein + rhs.protein,
                       carbohydrates: lhs.carbohydrates + rhs.carbohydrates,
                       fat: lhs.fat + rhs.fat,
                       calories: lhs.calories + rhs.calories)
    }
    
    internal static func zeroed() -> Macronutrients {
        Macronutrients(protein: 0, carbohydrates: 0, fat: 0, calories: 0)
    }
}

extension Macronutrients: CustomStringConvertible {
    public var description: String {
        get {
            return "I'll get you one day"
        }
    }
}

public enum FoodError : Error {
    case measurementNotFound
    case measurementMismatched
    case macrosNotFound
}
