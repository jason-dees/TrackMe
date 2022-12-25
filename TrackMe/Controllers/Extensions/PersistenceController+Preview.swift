//
//  PersistenceController+Preview.swift
//  TrackMe
//
//  Created by Jason Dees on 12/23/22.
//

import Foundation

extension PersistenceController {
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        let measurement = StoredMeasurement(context: viewContext)
        measurement.unitType = "grams"
        measurement.unitValue = 15.0
        let butterMacroGrams = StoredAmount(context: viewContext,
                                            measurement: StoredMeasurement(context: viewContext,
                                                                           unitType: "grams",
                                                                           unitValue: 15.0),
                                            macros: StoredMacronutrients(context: viewContext,
                                                                         protein: 1,
                                                                         carbohydrates: 2,
                                                                         fat: 8,
                                                                         calories: 150))
        let butterMacroTbsp = StoredAmount(context: viewContext,
                                           measurement: StoredMeasurement(context: viewContext,
                                                                          unitType: "tbsp",
                                                                          unitValue: 1.0),
                                           macros: StoredMacronutrients(context: viewContext,
                                                                        protein: 1,
                                                                        carbohydrates: 2,
                                                                        fat: 8,
                                                                        calories: 150))
        let butterMacroCups = StoredAmount(context: viewContext,
                                           measurement: StoredMeasurement(context: viewContext,
                                                                          unitType: "cups",
                                                                          unitValue: 0.0625),
                                           macros: StoredMacronutrients(context: viewContext,
                                                                        protein: 1,
                                                                        carbohydrates: 2,
                                                                        fat: 8,
                                                                        calories: 150))
        let breadMacroEach = StoredAmount(context: viewContext,
                                          measurement: StoredMeasurement(context: viewContext,
                                                                         unitType: "each",
                                                                         unitValue:2),
                                          macros: StoredMacronutrients(context: viewContext,
                                                                       protein: 3,
                                                                       carbohydrates: 20,
                                                                       fat: 2,
                                                                       calories: 150))
        
        let breadFood = StoredFood(context: viewContext,
                                  name: "Bread",
                                  amounts: [breadMacroEach])
        let butterFood = StoredFood(context: viewContext,
                                   name: "Butter",
                                   amounts: [butterMacroGrams, butterMacroTbsp, butterMacroCups])
        let _ = StoredFood(context: viewContext,
                           name: "Lunch Meat",
                           amounts: [
                           StoredAmount(context: viewContext,
                                        measurement: StoredMeasurement(context: viewContext, unitType: "grams", unitValue: 15.0),
                                        macros: StoredMacronutrients(context: viewContext,
                                                                     protein: 10,
                                                                     carbohydrates: 0,
                                                                     fat: 5,
                                                                     calories: 80))])
        let _ = StoredFood(context: viewContext,
                           name: "Vanilla Iced Cream",
                           amounts: [
                           StoredAmount(context: viewContext,
                                        measurement: StoredMeasurement(context: viewContext, unitType: "grams", unitValue: 100.0),
                                        macros: StoredMacronutrients(context: viewContext,
                                                                     protein: 10,
                                                                     carbohydrates: 45,
                                                                     fat: 20,
                                                                     calories: 380))])
        for i in 0...100 {
            let protein = Double.random(in: 0...100)
            let carbohydrates = Double.random(in: 0...100)
            let fat = Double.random(in: 0...100)
            let calories = protein * 4 + carbohydrates * 4 + fat * 8
            let unitGrams = Double.random(in: 0...100)
            let unitEach = Double.random(in: 0...5)
            let _ = StoredFood(context: viewContext,
                               name: "Some Food \(i)",
                               amounts: [
                               StoredAmount(context: viewContext,
                                            measurement: StoredMeasurement(context: viewContext, unitType: "grams", unitValue: unitGrams),
                                            macros: StoredMacronutrients(context: viewContext,
                                                                         protein: protein,
                                                                         carbohydrates: carbohydrates,
                                                                         fat: fat,
                                                                         calories: calories)),
                               StoredAmount(context: viewContext,
                                            measurement: StoredMeasurement(context: viewContext, unitType: "each", unitValue: unitEach),
                                            macros: StoredMacronutrients(context: viewContext,
                                                                         protein: protein/2,
                                                                         carbohydrates: carbohydrates/2,
                                                                         fat: fat/2,
                                                                         calories: calories/2))])
        }
        let eatenBread = StoredEatenFood(context: viewContext,
                                         order: 0,
                                         food: breadFood,
                                         measurement: StoredMeasurement(context: viewContext, unitType: "each", unitValue: 1.0))
        let eatenButter = StoredEatenFood(context: viewContext,
                                          order: 1,
                                          food: butterFood,
                                          measurement: StoredMeasurement(context: viewContext, unitType: "grams", unitValue: 100.0))
        let meal = StoredMeal(context: viewContext,
                              name: "Lunch 0",
                              order: 0,
                              eatenFoods: [eatenBread, eatenButter])
        
        let eatenBreadTwo = StoredEatenFood(context: viewContext,
                                            order: 0,
                                            food: breadFood,
                                            measurement: StoredMeasurement(context: viewContext, unitType: "each", unitValue: 1.0))
        
        let eatenBreadThree = StoredEatenFood(context: viewContext,
                                              order: 1,
                                              food: breadFood,
                                            measurement: StoredMeasurement(context: viewContext, unitType: "each", unitValue: 1.0))
        let mealOne = StoredMeal(context: viewContext,
                                 name: "Pre-Lunch 1",
                                 order: 1,
                                 eatenFoods: [eatenBreadTwo, eatenBreadThree])
        let day = StoredDay(context: viewContext,
                            date: Date.now,
                            meals: [mealOne, meal],
                            calorieLimit: 2000)
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
