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
            NSLog("Updating foods")
        }
        didSet {
            self.foods = self.storedFoods.map { $0.food }
        }
    }
    
    @Published var foods: [Food] = []
    
    private var cancellable: AnyCancellable?
    
    convenience init(context moc: NSManagedObjectContext) {
        self.init(publisher: FoodController(context: moc).foods.eraseToAnyPublisher())
    }
    
    init(publisher: AnyPublisher<[StoredFood], Never>) {
        cancellable = publisher.sink { foods in
            NSLog("Updating edibles")
            self.storedFoods = foods
        }
    }
}
