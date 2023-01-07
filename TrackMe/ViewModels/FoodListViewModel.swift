//
//  EdibleListViewModel.swift
//  TrackMe
//
//  Created by Jason Dees on 12/24/22.
//

import Combine
import CoreData
import Foundation

class FoodListViewModel: ObservableObject {
    @Published var storedFoods: [StoredFood] = [] {
        willSet {
            NSLog("\(FoodListViewModel.self) willSet Updating foods")
        }
        didSet {
            applyFoodFilter(foodFilter)
        }
    }
    
    @Published var foodFirstLetters: [String] = []
    
    @Published var filteredFoods: [StoredFood] = []{
        didSet {
            foodFirstLetters = Array(Set(filteredFoods.map { String($0.food.name.prefix(1)).uppercased() })).sorted { $0.lowercased() < $1.lowercased() }
        }
    }
    
    private var cancellable: AnyCancellable?
    public var foodFilter: String {
        didSet {
            applyFoodFilter(foodFilter)
        }
    }
    
    init(publisher: AnyPublisher<[StoredFood], Never>) {
        self.foodFilter = ""
        cancellable = publisher.sink { foods in
            NSLog("\(FoodListViewModel.self) Updating foods sink")
            self.storedFoods = foods.sorted { $0.food.name.lowercased() < $1.food.name.lowercased() }
        }
    }
    
    func applyFoodFilter(_ contains: String) {
        if contains.isEmpty {
            filteredFoods = storedFoods
        }
        else {
            filteredFoods = storedFoods.filter { $0.food.name.lowercased().contains(contains.lowercased()) }
        }
    }
}
