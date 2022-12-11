//
//  DayView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/1/22.
//

import SwiftUI

struct DayView: View {
    @State var day: Day
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(day.meals, id: \.self.name){ meal in
                    VStack {
                        Group {
                            HStack {
                                Text(meal.name)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Button(action: addFood) {
                                    Image(systemName: "plus")
                                }
                            }.padding(10)
                            Text("Macros: \(String(describing: try? meal.macros))")
                                .font(.title3)
                                .padding(0)
                        }
                        ForEach(meal.eaten, id: \.self.name) { eaten in
                            VStack {
                                Text(eaten.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                    .padding(10)
                                Text("Macros: \(String(describing: try? eaten.macros))").padding(0)
                            }.padding(10)
                                .swipeActions {
                                    Button {
                                        print("Remove food")
                                    } label: {
                                        Text("Remove")
                                    }
                                    .tint(.red)
                                    Button {
                                        print("Edit food")
                                    } label: {
                                        Text("Edit")
                                    }
                                    .tint(.yellow)
                                }
                        }
                    }.border(.black)
                }
            }
            .navigationTitle(day.date.medium)
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
#endif
                ToolbarItem(placement: .bottomBar) {
                    Button(action: addFood) {
                        Label("Add Food", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addFood() {
        
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        let butterMacroGrams = Amount(measurement: .grams(15.0), macros: Macronutrients(protein: 1, carbohydrates: 2, fat: 8, calories: 150))
        let butterMacroTbsp = Amount(measurement: .tbsp(1.0), macros: Macronutrients(protein: 1, carbohydrates: 2, fat: 8, calories: 150))
        let butterMacroCups = Amount(measurement: .cups(0.0625), macros: Macronutrients(protein: 1, carbohydrates: 2, fat: 8, calories: 150))
        let butterEdible = Edible(name: "butter", amounts: [butterMacroGrams, butterMacroTbsp, butterMacroCups])
        let breadMacroEach = Amount(measurement: .each(2), macros: Macronutrients(protein: 3, carbohydrates: 20, fat: 2, calories: 150))
        let breadEdible = Edible(name: "bread", amounts: [breadMacroEach])
        let eatenBread = Eaten(food: Food(name: "Bread", edible: breadEdible, measurement: .each(2)))
        let eatenButter = Eaten(food: Food(name: "Butter", edible: butterEdible, measurement: .grams(45)))
        let meal = Meal(name: "Lunch", eaten: [eatenBread, eatenBread])
        let mealOne = Meal(name: "Pre-Lunch", eaten: [eatenBread, eatenButter])
        let day = Day(date: Date.now,
                      meals: [mealOne, meal, mealOne],
                      calorieLimit: 2000)
        DayView(day: day)
    }
}
