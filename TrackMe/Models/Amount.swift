//
//  Amount.swift
//  TrackMe
//
//  Created by Jason Dees on 12/12/22.
//

import Foundation

public struct Amount {
    public var id: UUID
    public let measurement: Measurement
    public let macros: Macronutrients
    
    public init(id: UUID, measurement: Measurement, macros: Macronutrients) {
        self.id = id
        self.measurement = measurement
        self.macros = macros
    }
    
    public init() {
        self.init(id: UUID(), measurement: Measurement.defaultValue, macros: Macronutrients())
    }
}

extension Amount {
    public var quantity: Double {
        self.measurement.quantity
    }
}

//TODO: Move to Foundation's Measurement object now that I have a ViewModel + transform pattern

public enum Measurement { // macros have a measurement associated with them
    case cups(Double)
    case grams(Double)
    case each(Double)
    case liters(Double)
    case tbsp(Double)
    case tsp(Double)
}

extension Measurement { // a measurement has macros, macros don't have a measurement
    public var quantity: Double {
        switch self {
        case let .cups(amount):
            return amount
        case let .grams(amount):
            return amount
        case let .each(amount):
            return amount
        case let .liters(amount):
            return amount
        case let .tbsp(amount):
            return amount
        case let .tsp(amount):
            return amount
        }
    }
    
    public static var defaultValue: Measurement {
        get {
            .each(-1.0)
        }
    }
    public var unit: String {
        switch self {
        case .cups(_):
            return "cups"
        case .grams(_):
            return "grams"
        case .each(_):
            return "each"
        case .liters(_):
            return "liters"
        case .tbsp(_):
            return "tbsp"
        case .tsp(_):
            return "tsp"
        }
    }
    
    public var formattedQuantity: String {
        return NumberFormatter.formatString(quantity)
    }
}

extension Measurement: Equatable {
    public static func ==(lhs: Measurement, rhs: Measurement) -> Bool {
        switch (lhs,rhs) {
        case (.cups, .cups):
            return true
        case (.grams, .grams):
            return true
        case (.each, .each):
            return true
        case (.liters, .liters):
            return true
        case (.tbsp, .tbsp):
            return true
        case (.tsp, .tsp):
            return true
        default:
            return false
        }

    }
}
