//
//  Meal.swift
//  TrackMe
//
//  Created by Jason Dees on 12/12/22.
//

import Foundation

public struct Meal {
    public let name: String
    public let eaten: [EatenFood]
    
    public init(name: String, eaten: [EatenFood]) {
        self.name = name
        self.eaten = eaten
    }
}

extension Meal {
    public var macros: Macronutrients {
        get throws {
            return try self.eaten.reduce(Macronutrients.zeroed(), {
                try $0 + $1.macros
            })
        }
    }
}

