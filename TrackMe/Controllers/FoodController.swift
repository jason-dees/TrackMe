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
    
    init(context moc: NSManagedObjectContext = PersistenceController.preview.container.viewContext) {
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
    
    func renameFood(_ id: UUID, newName: String) {
        guard let renamedFood = foods.value.first(where: { $0.id == id }) else {
            return
        }
        renameFood(renamedFood, newName: newName)
    }
    
    func renameFood(_ food: StoredFood, newName: String){
        print(food.name ?? "Old name not found")
        food.name = newName
        print(food.name ?? "Name not found")
        do {
            try PersistenceController.preview.container.viewContext.save()
            
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
