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
        self.id = UUID()
        self.unitType = unitType
        self.unitValue = unitValue
    }
    
    public var measurement: Measurement {
        get {
            switch self.unitType {
            case "cups":
                return Measurement.cups(self.unitValue)
            case "grams":
                return Measurement.grams(self.unitValue)
            case "tbsp":
                return Measurement.tbsp(self.unitValue)
            case "each":
                return Measurement.each(self.unitValue)
            case "tsp":
                return Measurement.tsp(self.unitValue)
            case "liters":
                return Measurement.liters(self.unitValue)
            default:
                return Measurement.defaultValue
            }
        }
    }
    
    public var uiUnitType: String {
        get {
            self.unitType ?? "Unknown"
        }
        set {
            self.unitType = newValue
        }
    }
    
    public var uiUnitValue: String {
        get {
            String(self.unitValue)
        }
        set {
            if let newDouble = Double(newValue){
                self.unitValue = newDouble
            }
        }
    }
}
