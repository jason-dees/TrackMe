//
//  StoredAmount+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/15/22.
//

import CoreData
import Foundation

extension StoredAmount {
    
    public convenience init(context moc: NSManagedObjectContext, measurement: StoredMeasurement, macros: StoredMacronutrients) {
        self.init(context: moc)
        self.id = UUID();
        self.measurement = measurement
        self.macros = macros
    }
    
    public var amount: Amount {
        get {
            Amount(id: self.id ?? UUID(), measurement: self.measurement?.measurement ?? Measurement.defaultValue,
                   macros: self.macros?.macros ?? Macronutrients())
        }
    }
    
    public var uiUnitType: String {
        get {
            if let measurement = self.measurement {
                return measurement.uiUnitType
            }
            return "Unknown"
        }
        set {
            
            if let measurement = self.measurement {
                measurement.uiUnitType = newValue
            }
        }
    }
    
    public var uiUnitValue: String {
        get {
            if let measurement = self.measurement {
                return measurement.uiUnitValue
            }
            return "Unknown"
        }
        set {
            
            if let measurement = self.measurement {
                measurement.uiUnitValue = newValue
            }
        }
    }
    
    public var uiCalories: String {
        get {
            if let macros = self.macros {
                return macros.uiCalories
            }
            return "Unknown Calories"
        }
        set {
            
            if let macros = self.macros {
                macros.uiCalories = newValue
            }
        }
    }
    
    public var uiFat: String {
        get {
            if let macros = self.macros {
                return macros.uiFat
            }
            return "Unknown Fat"
        }
        set {
            
            if let macros = self.macros {
                macros.uiFat = newValue
            }
        }
    }
}

