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
            if let set = self.amounts as? Set<StoredAmount> {
                return Array(set)
            }
            return []
        }
    }
    
    public var food: Food {
        get {
            Food(id: self.id ?? UUID(), name: self.name ?? "Unknown food",
                 amounts: amountsArray.map { $0.amount })
        }
    }
}

extension StoredFood {
    public var uiName: String {
        get {
            self.name ?? "Unknown"
        }
        set {
            self.name = newValue
        }
    }
}
