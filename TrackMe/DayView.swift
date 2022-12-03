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
            VStack(
                alignment: .leading,
                spacing: 0
            ){
                Text(day.date.medium).frame(maxWidth: .infinity, alignment: .center)
                    .padding(10)
                ForEach(day.meals, id: \.self.name){ meal in
                    List {
                        VStack {
                            HStack {
                                Text(meal.name)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Button(action: addFood) {
                                    Image(systemName: "plus")
                                }
                            }
                            Text("Macros")
                        }
                        // meal macro view here
                        ForEach(meal.eaten, id: \.self.name) { eaten in
                            
                            VStack {
                                Text(eaten.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Macros")
                            }
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
                            // eaten macro view here
                        }
                    }
                }
                
            }.toolbar {
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
        let breadMacroEach = Amount(measurement: .each(2), macros: Macronutrients(protein: 3, carbohydrates: 20, fat: 2, calories: 150))
        let breadEdible = Edible(name: "bread", amounts: [breadMacroEach])
        let eatenBread = Eaten(food: Food(name: "Bread", edible: breadEdible, measurement: .each(2)))
        let meal = Meal(name: "Lunch", eaten: [eatenBread])
        let mealOne = Meal(name: "Pre-Lunch", eaten: [eatenBread])
        let day = Day(date: Date.now,
                      meals: [mealOne, meal],
                      calorieLimit: 2000)
        DayView(day: day)
    }
}
