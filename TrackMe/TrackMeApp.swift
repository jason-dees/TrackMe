//
//  TrackMeApp.swift
//  TrackMe
//
//  Created by Jason Dees on 11/23/22.
//

import SwiftUI

@main
struct TrackMeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let breadMacroEach = Amount(measurement: .each(2), macros: Macronutrients(protein: 3, carbohydrates: 20, fat: 2, calories: 150))
            let breadEdible = Edible(name: "bread", amounts: [breadMacroEach])
            let eatenBread = Eaten(food: Food(name: "Bread", edible: breadEdible, measurement: .each(2)))
            let meal = Meal(name: "Lunch", eaten: [eatenBread])
            let mealOne = Meal(name: "Pre-Lunch", eaten: [eatenBread])
            let day = Day(date: Date.now,
                          meals: [mealOne, meal],
                          calorieLimit: 2000)
            DayView(day: day)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
