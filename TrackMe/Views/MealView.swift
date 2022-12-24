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
            Group {
                HStack {
                    Text(meal.name)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button(action: addFood) {
                        Image(systemName: "plus")
                    }
                }
                .padding(10)
                MacrosView(macros: meal.macros)
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(height: 90.0)
            }
            ForEach(meal.eaten, id: \.self.id) { eaten in
                VStack {
                    Text(eaten.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .padding(5)
                    MacrosView(macros: eaten.macros)
                        .frame(height: 50.0)
                }
                .background(.gray)
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
        }
    }
    
    private func addFood() {
        
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        let day = DayViewModel(dayPublisher: DayController.preview.days.eraseToAnyPublisher()).today
        
        MealView(meal: day.meals.first ?? Meal())
    }
}
