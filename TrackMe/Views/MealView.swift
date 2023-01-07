//
//  MealView.swift
//  TrackMe
//
//  Created by Jason Dees on 11/23/22.
//

import SwiftUI

struct MealView: View {
    @State var meal: Meal
    var shouldShowMealButtons: [UUID: Bool] = [:]
    var body: some View {
        VStack {
            HStack {
                Text(meal.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: addFood) {
                    Image(systemName: "plus")
                }
            }
            .font(.title2)
            .padding(10)
            MacrosView(macros: meal.macros)
                .font(.title3)
                .fontWeight(.bold)
                .frame(height: 90.0)
            Divider()
            ForEach(meal.eaten, id: \.self.id) { eaten in
                EatenFoodView(eatenFood: eaten).onTapGesture {
                    addFood()
                }
                Divider()
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 5.0, style: .circular)
                .stroke(.white, lineWidth: 0.5)
                .shadow(color: .gray, radius: 1, x: 0, y: 0)
        }
    }
    
    private func addFood() {
        
    }
    private func removeFood() {
        
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        let day = DayViewModel(publisher: DayController.preview.days.eraseToAnyPublisher()).today
        
        MealView(meal: day.meals.first ?? Meal())
    }
}
