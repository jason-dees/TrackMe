//
//  StoredFood+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/15/22.
//

import CoreData
import Foundation

extension StoredFood {
    public convenience init(context moc: NSManagedObjectContext, name: String, edible: StoredEdible, measurement: StoredMeasurement) {
        self.init(context: moc)
        self.name = name
        self.edible = edible
        self.measurement = measurement
    }
    
    public var food: Food {
        get {
            Food(name: self.name ?? "Unknown food",
                 edible: self.edible?.edible ?? Edible(),
                 measurement: self.measurement?.measurement ?? Measurement.defaultValue)
        }
    }
}
