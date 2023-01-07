//
//  FoodView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/25/22.
//

import SwiftUI

struct FoodView: View {
   
    @Environment(\.foodController) private var foodController
    @Binding var food: StoredFood
    
    var body: some View {
        VStack {
            Text(food.food.name)
            Text(food.food.id.uuidString)
            Button("rename") {
                foodController.renameFood(food.food.id, newName: "a new name \(food.food.name)")
                //viewModel.renameFood(food, newName: "a new name")
            }
        }
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        //FoodView(food: Food())
        Text("so fake")
    }
}
