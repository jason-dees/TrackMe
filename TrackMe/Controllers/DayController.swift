//
//  DayController.swift
//  TrackMe
//
//  Created by Jason Dees on 12/23/22.
//

import Combine
import CoreData
import Foundation

//https://betterprogramming.pub/swiftui-and-coredata-the-mvvm-way-ab9847cbff0f

class DayController: NSObject, ObservableObject {
    var days = CurrentValueSubject<[StoredDay], Never>([])
    private let dayFetchController: NSFetchedResultsController<StoredDay>
    
    static let shared = DayController()
    static let preview = DayController(context: PersistenceController.preview.container.viewContext)
    
    private init(context moc: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        
        let fetchRequest = StoredDay.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \StoredDay.date, ascending: true)]
        dayFetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                        managedObjectContext: moc,
                                                        sectionNameKeyPath: nil,
                                                        cacheName: nil)
        
        super.init()
        
        dayFetchController.delegate = self
        
        do {
            try dayFetchController.performFetch()
            days.value = dayFetchController.fetchedObjects ?? []
        }
        catch {
            NSLog("Error: could not fetch Day objects")
        }
    }
}


extension DayController: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let days = controller.fetchedObjects as? [StoredDay] else { return }
        NSLog("Context has changed; reloading Days")
        self.days.value = days
    }
}
