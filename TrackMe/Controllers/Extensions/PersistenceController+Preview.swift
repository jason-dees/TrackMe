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
        let butterEdible = StoredEdible(context: viewContext,
                                        name: "butter",
                                        amounts: [butterMacroGrams, butterMacroTbsp, butterMacroCups])
        let breadMacroEach = StoredAmount(context: viewContext,
                                          measurement: StoredMeasurement(context: viewContext,
                                                                         unitType: "each",
                                                                         unitValue:2),
                                          macros: StoredMacronutrients(context: viewContext,
                                                                       protein: 3,
                                                                       carbohydrates: 20,
                                                                       fat: 2,
                                                                       calories: 150))
        let breadEdible = StoredEdible(context: viewContext,
                                       name: "bread",
                                       amounts: [breadMacroEach])
        let eatenBread = StoredEatenFood(context: viewContext,
                                         food: StoredFood(context: viewContext,
                                                          name: "Lunch Bread",
                                                          edible: breadEdible,
                                                          measurement: StoredMeasurement(context: viewContext,
                                                                                         unitType: "each",
                                                                                         unitValue: 2)))
        let eatenButter = StoredEatenFood(context: viewContext,
                                          food: StoredFood(context: viewContext,
                                                           name: "Butter",
                                                           edible: butterEdible,
                                                           measurement: StoredMeasurement(context: viewContext,
                                                                                          unitType: "grams",
                                                                                          unitValue: 45)))
        let meal = StoredMeal(context: viewContext,
                              name: "Lunch",
                              eatenFoods: [eatenBread, eatenButter])
        
        let eatenBreadTwo = StoredEatenFood(context: viewContext,
                                            food: StoredFood(context: viewContext,
                                                             name: "Bread",
                                                             edible: breadEdible,
                                                             measurement: StoredMeasurement(context: viewContext,
                                                                                            unitType: "each",
                                                                                            unitValue: 2)))
        
        let eatenBreadThree = StoredEatenFood(context: viewContext,
                                              food: StoredFood(context: viewContext,
                                                               name: "Bread Again",
                                                               edible: breadEdible,
                                                               measurement: StoredMeasurement(context: viewContext,
                                                                                              unitType: "each",
                                                                                              unitValue: 2)))
        let mealOne = StoredMeal(context: viewContext,
                                 name: "Pre-Lunch",
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
