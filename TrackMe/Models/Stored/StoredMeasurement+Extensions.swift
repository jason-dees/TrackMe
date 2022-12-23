//
//  StoredMeasurement+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/15/22.
//

import CoreData
import Foundation

extension StoredMeasurement {
    public convenience init(context moc: NSManagedObjectContext, unitType: String, unitValue: Double) {
        self.init(context: moc)
        self.unitType = unitType
        self.unitValue = unitValue
    }
    
    public var measurement: Measurement {
        get {
            switch self.unitType {
            case "cups":
                return Measurement.cups(self.unitValue)
            default:
                return Measurement.defaultValue
            }
        }
    }
}
