//
//  MealView.swift
//  TrackMe
//
//  Created by Jason Dees on 11/23/22.
//

import SwiftUI

struct MealView: View {
    @State var meal: Meal
    var body: some View {
        VStack {
            Text(meal.name).font(.headline)
            // meal macro view here
            ForEach(meal.eaten, id: \.self.name) { eaten in
                Text(eaten.name)
                // eaten macro view here
            }
        }
        .multilineTextAlignment(.leading)
    }
    
    private func addFood() {
        
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        let breadMacroEach = Amount(measurement: .each(2), macros: Macronutrients(protein: 3, carbohydrates: 20, fat: 2, calories: 150))
        let breadEdible = Edible(name: "bread", amounts: [breadMacroEach])
        let eatenBread = Eaten(food: Food(name: "Bread", edible: breadEdible, measurement: .each(2)))
        let meal = Meal(name: "Lunch", eaten: [eatenBread])
        MealView(meal: meal)
    }
}
