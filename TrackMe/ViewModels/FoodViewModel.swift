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
    @Published var storedFoods: [StoredFood] = [] {
        willSet {
            NSLog("\(FoodViewModel.self) willSet Updating foods")
        }
        didSet {
            self.foods = self.storedFoods.map { $0.food }
        }
    }
    
    @Published var foods: [Food] = []
    
    private var cancellable: AnyCancellable?
    
    init(publisher: AnyPublisher<[StoredFood], Never>) {
        cancellable = publisher.sink { foods in
            NSLog("\(FoodViewModel.self) Updating foods from sink")
            self.storedFoods = foods
        }
    }
    
    public func renameFood(_ food: StoredFood, newName: String) {
        FoodController.shared.renameFood(food, newName: newName)
    }

}
