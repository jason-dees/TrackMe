//
//  FoodView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/25/22.
//

import SwiftUI

struct FoodView: View {
    
    @StateObject var viewModel: FoodViewModel
    
    var body: some View {
        Form {
            Text(viewModel.food.food.id.uuidString).font(.caption2)
            TextField("Food Name", text: $viewModel.name).font(.title)
            Picker("Serving Sizes", selection: $viewModel.selectedAmountId) {
                ForEach(viewModel.amounts, id: \.id) { amount in
                    Text("\(amount.measurement.formattedQuantity) \(amount.measurement.unit)")
                }
            }
            Section("Nutrients") {
                HStack {
                    Text("Calories").font(.title)
                    TextField("", text: $viewModel.uiCalories)
                        .font(.title)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Total Fat")
                        .font(.body).fontWeight(.bold)
                    TextField("", text: $viewModel.uiFat)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.trailing)
                    Spacer()
                    Text("g")
                        .font(.body)
                }
                HStack {
                    Text("Total Carbohydrate")
                        .font(.body).fontWeight(.bold)
                    TextField("", text: $viewModel.uiCarbs)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.trailing)
                    Spacer()
                    Text("g")
                        .font(.body)
                }
                HStack {
                    Text("Total Protein")
                        .font(.body).fontWeight(.bold)
                    TextField("", text: $viewModel.uiProtein)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.trailing)
                    Spacer()
                    Text("g")
                        .font(.body)
                }
            }.font(.headline)
            
            Button("Save") {
            }.frame(alignment: .trailing)
            Button("Cancel") {
            }.frame(alignment: .bottom)
        }.border(.orange)
            .frame(maxWidth: .infinity)
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let butterMacroGrams = StoredAmount(context: viewContext,
                                            measurement: StoredMeasurement(context: viewContext,
                                                                           unitType: "grams",
                                                                           unitValue: 30.0),
                                            macros: StoredMacronutrients(context: viewContext,
                                                                         protein: 2,
                                                                         carbohydrates: 4,
                                                                         fat: 16,
                                                                         calories: 300))
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
        let food = StoredFood(context: viewContext,
                              name: "Butter",
                              amounts: [butterMacroGrams, butterMacroTbsp, butterMacroCups])
        let vm = FoodViewModel(food, foodController: FoodController.preview)
        FoodView(viewModel: vm)
        
    }
}
