//
//  FoodViewModel.swift
//  TrackMe
//
//  Created by Jason Dees on 12/27/22.
//

import Combine
import CoreData
import Foundation

class FoodViewModel: ObservableObject {
    @Published var food: StoredFood {
        didSet {
            self.amounts = food.amountsArray.map {$0.amount}
            self.name = food.name ?? "Unknown name"
            self.selectedAmountId = food.amountsArray.first?.amount.id ?? UUID()
        }
    }
    let foodController: FoodController
    private var cancellable: AnyCancellable?
    
    @Published var name: String = "Unknown"
    @Published var amounts: [Amount] = []
    var selectedAmount: Amount = Amount()
    @Published var selectedAmountId: UUID = UUID() {
        didSet {
            self.selectedAmount = food.amountsArray.first { $0.id == self.selectedAmountId }?.amount ?? Amount()
            self.uiCalories = NumberFormatter.formatString(self.selectedAmount.macros.calories)
            self.uiFat = NumberFormatter.formatString(self.selectedAmount.macros.fat)
            self.uiCarbs = NumberFormatter.formatString(self.selectedAmount.macros.carbohydrates)
            self.uiProtein = NumberFormatter.formatString(self.selectedAmount.macros.protein)
        }
    }
    
    @Published var uiCalories: String = "Unset Calories"
    @Published var uiFat: String = "Unset Fat"
    @Published var uiCarbs: String = "Unset Carbohydrates"
    @Published var uiProtein: String = "Unset Protein"
    
    public init(_ food: StoredFood, foodController: FoodController){
        self.food = food
        self.foodController = foodController
        
        let publisher: AnyPublisher<[StoredFood], Never> = foodController.foods.eraseToAnyPublisher()
        cancellable = publisher.sink { foods in
            NSLog("\(FoodListViewModel.self) Updating foods sink")
            if let food = foods.first(where: { $0.id == food.id }) {
                self.food = food
            }
        }
    }
}
