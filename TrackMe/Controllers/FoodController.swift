//
//  FoodController.swift
//  TrackMe
//
//  Created by Jason Dees on 12/24/22.
//

import Combine
import CoreData
import Foundation
import SwiftUI

class FoodController: NSObject, ObservableObject {
    var foods = CurrentValueSubject<[StoredFood], Never>([])
    private let foodFetchController: NSFetchedResultsController<StoredFood>
    
    static let shared = FoodController(context: PersistenceController.shared.container.viewContext)
    static let preview = FoodController(context: PersistenceController.preview.container.viewContext)

    init(context moc: NSManagedObjectContext) {
        let fetchRequest = StoredFood.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \StoredFood.name, ascending: true)]
        
        foodFetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                        managedObjectContext: moc,
                                                        sectionNameKeyPath: nil,
                                                        cacheName: nil)
        
        super.init()
        
        foodFetchController.delegate = self
        
        do {
            try foodFetchController.performFetch()
            foods.value = foodFetchController.fetchedObjects ?? []
        }
        catch {
            NSLog("Error: could not fetch Food objects")
        }
    }
}

extension FoodController: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let foods = controller.fetchedObjects as? [StoredFood] else { return }
        NSLog("Context has changed; reloading Foods")
        self.foods.value = foods
    }
}
