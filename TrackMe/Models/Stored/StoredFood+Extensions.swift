//
//  StoredFood+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/15/22.
//

import CoreData
import Foundation

extension StoredFood {
    public convenience init(context moc: NSManagedObjectContext, name: String, amounts: [StoredAmount]) {
        self.init(context: moc)
        self.id = UUID()
        self.name = name
        self.amounts = Set(amounts) as NSSet
    }
    
    public var amountsArray: [StoredAmount] {
        get {
            self.amounts?.allObjects as? [StoredAmount] ?? []
        }
    }
    
    public var food: Food {
        get {
            Food(id: self.id ?? UUID(), name: self.name ?? "Unknown food",
                 amounts: amountsArray.map { $0.amount })
        }
    }
}
