//
//  DayView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/1/22.
//

import SwiftUI

struct MainTabView: View {
    @State var day: Day
    var body: some View {
        TabView {
            DayView(day: day)
                .badge(0)
                .tabItem {
                    Label("Day", systemImage: "calendar")
                }
            Text("some other view")
                .badge(0)
                .tabItem {
                    Label("Foods", systemImage: "carrot")
                }
        }
    }
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        let butterMacroGrams = Amount(measurement: .grams(15.0), macros: Macronutrients(protein: 1, carbohydrates: 2, fat: 8, calories: 150))
        let butterMacroTbsp = Amount(measurement: .tbsp(1.0), macros: Macronutrients(protein: 1, carbohydrates: 2, fat: 8, calories: 150))
        let butterMacroCups = Amount(measurement: .cups(0.0625), macros: Macronutrients(protein: 1, carbohydrates: 2, fat: 8, calories: 150))
        let butterEdible = Edible(name: "butter", amounts: [butterMacroGrams, butterMacroTbsp, butterMacroCups])
        let breadMacroEach = Amount(measurement: .each(2), macros: Macronutrients(protein: 3, carbohydrates: 20, fat: 2, calories: 150))
        let breadEdible = Edible(name: "bread", amounts: [breadMacroEach])
        let eatenBread = EatenFood(food: Food(name: "Bread", edible: breadEdible, measurement: .each(2)))
        let eatenButter = EatenFood(food: Food(name: "Butter", edible: butterEdible, measurement: .grams(45)))
        let meal = Meal(name: "Lunch", eaten: [eatenBread, eatenBread])
        let mealOne = Meal(name: "Pre-Lunch", eaten: [eatenBread, eatenButter])
        let day = Day(date: Date.now,
                      meals: [mealOne, meal, mealOne],
                      calorieLimit: 2000)
        MainTabView(day: day)
    }
}
