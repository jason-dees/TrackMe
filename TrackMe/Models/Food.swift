//
//  Food.swift
//  TrackMe
//
//  Created by Jason Dees on 11/24/22.
//

import Foundation

public struct Food { // A logged edible
    public let name: String
    public let longDescription: String
    public let edible: Edible // Do i want to copy the edible information? Just macros here
    public let measurement: Measurement
    
    public init(name: String, longDescription: String = "", edible: Edible, measurement: Measurement) {
        self.name = name
        self.longDescription = longDescription
        self.edible = edible
        self.measurement = measurement
    }
}

extension Food {
    public var macros: Macronutrients {
        get throws {
            guard let baseAmount = self.edible.amounts.first(where: {$0.measurement == self.measurement}) else {
                throw FoodError.measurementNotFound
            }
            let percentOfBase: Double = self.measurement.quantity / baseAmount.quantity
            return baseAmount.macros * percentOfBase
        }
    }
    
    public init() {
        self.init(name: "Unknown Food",
                  longDescription: "Food was not found so this default value was created",
                  edible: Edible(),
                  measurement: Measurement.defaultValue)
    }
}

public enum FoodError : Error {
    case measurementNotFound
    case measurementMismatched
    case macrosNotFound
}
