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
        self.measurement = measurement
        self.macros = macros
    }
    
    public var amount: Amount {
        get {
            Amount(measurement: self.measurement?.measurement ?? Measurement.defaultValue,
                   macros: self.macros?.macros ?? Macronutrients())
        }
    }
}
