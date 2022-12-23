//
//  StoredEdible+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/15/22.
//

import CoreData
import Foundation

extension StoredEdible {
    public convenience init(context moc: NSManagedObjectContext, name: String, amounts: [StoredAmount]) {
        self.init(context: moc)
        self.name = name
        self.amounts = Set(amounts) as NSSet
    }
    
    public var amountsArray: [StoredAmount] {
        get {
            self.amounts?.allObjects as? [StoredAmount] ?? []
        }
    }
    
    public var edible: Edible {
        get {
            Edible(name: self.name ?? "Uknown Edible", amounts: self.amountsArray.map { $0.amount })
        }
    }
}
