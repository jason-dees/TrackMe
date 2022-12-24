//
//  StoredEatenFood.swift
//  TrackMe
//
//  Created by Jason Dees on 12/15/22.
//

import CoreData
import Foundation

extension StoredEatenFood {
    
    public convenience init(context moc: NSManagedObjectContext, order: Int, food: StoredFood, measurement: StoredMeasurement) {
        self.init(context: moc)
        self.order = Int16(order)
        self.food = food
        self.measurement = measurement
    }
    
    public convenience init(context moc: NSManagedObjectContext, recipe: StoredRecipe) {
        self.init(context: moc)
        self.recipe = recipe
    }
    
    public var name: String {
        get {
            self.food?.name ?? self.recipe?.name ?? "Eaten Food Name Not Found"
        }
    }
    
    public var macros: StoredMacronutrients? {
        get {
            //self.food?.macros ?? self.recipe?.macros ?? "Eaten Food Name Not Found"
            //StoredMacronutrients(protein: 0.0, carbohydrates: 0.0, fat: 0.0, calories: 0)
            nil
        }
    }
    
    public var eatenFood: EatenFood {
        get {
            if let food = self.food {
                return EatenFood(food: food.food, measurement: measurement?.measurement ?? Measurement.defaultValue)
            }
            if let recipe = self.recipe {
                return EatenFood(recipe: recipe.recipe, measurement: measurement?.measurement ?? Measurement.defaultValue)
            }
            return EatenFood()
        }
    }
}
