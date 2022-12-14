//
//  Food.swift
//  TrackMe
//
//  Created by Jason Dees on 11/24/22.
//

import Foundation

public struct Food { // A logged edible
    public let id: UUID
    public let name: String
    public let longDescription: String
    public let amounts: [Amount] // A measurements can have differing macro amounts
    public let icon: String = "carrot"
    
    public init(id: UUID, name: String, longDescription: String = "", amounts: [Amount]) {
        self.id = id
        self.name = name
        self.longDescription = longDescription
        self.amounts = amounts
    }
    
    public func amount(for measurement: Measurement) -> Amount {
        guard let baseAmount = amounts.first(where: {$0.measurement == measurement}) else {
            NSLog("Macronutrients not found for food \(self.name) and \(measurement)")
            return Amount()
        }
        return baseAmount
    }
    
    public func macros(for measurement: Measurement) -> Macronutrients {
        let baseAmount = amount(for: measurement)
        let percentOfBase: Double = measurement.quantity / baseAmount.quantity
        return baseAmount.macros * percentOfBase
    }
}

extension Food {
    public init() {
        self.init(id: UUID(),
                  name: "Unknown Food",
                  longDescription: "Food was not found so this default value was created",
                  amounts: [])
    }
}

public enum FoodError : Error {
    case measurementNotFound
    case measurementMismatched
    case macrosNotFound
}
