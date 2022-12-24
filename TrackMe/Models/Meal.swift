//
//  Meal.swift
//  TrackMe
//
//  Created by Jason Dees on 12/12/22.
//

import Foundation

public struct Meal {
    public var id: UUID = UUID()
    public let name: String
    public let eaten: [EatenFood]
    
    public init(name: String, eaten: [EatenFood]) {
        self.name = name
        self.eaten = eaten
    }
    
    public init() {
        self.init(name: "Unknown Meal", eaten: [])
    }
}

extension Meal {
    public var macros: Macronutrients {
        get {
            return self.eaten.reduce(Macronutrients.zeroed(), {
                $0 + $1.macros
            })
        }
    }
}

