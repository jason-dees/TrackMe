//
//  Macronutrients.swift
//  TrackMe
//
//  Created by Jason Dees on 12/12/22.
//

import Foundation

public struct Macronutrients {
    public let protein: Double
    public let carbohydrates: Double
    public let fat: Double
    public let calories: Double
    
    public init(protein: Double, carbohydrates: Double, fat: Double, calories: Double) {
        self.protein = protein
        self.carbohydrates = carbohydrates
        self.fat = fat
        self.calories = calories
    }
    
    public init() {
        self.init(protein: -1.0, carbohydrates: -1.0, fat: -1.0, calories: -1)
    }
}
extension Macronutrients: Equatable {
    public static func ==(lhs: Macronutrients, rhs: Macronutrients) -> Bool {
        return lhs.protein == rhs.protein
        && lhs.carbohydrates == rhs.carbohydrates
        && lhs.fat == rhs.fat
        && lhs.calories == rhs.calories
    }
    
    public static func *(lhs: Macronutrients, rhs: Double) -> Macronutrients {
        Macronutrients(protein: lhs.protein * rhs,
                       carbohydrates: lhs.carbohydrates * rhs,
                       fat: lhs.fat * rhs,
                       calories: lhs.calories * rhs)
    }
    
    public static func /(lhs: Macronutrients, rhs: Double) -> Macronutrients {
        Macronutrients(protein: lhs.protein / rhs,
                       carbohydrates: lhs.carbohydrates / rhs,
                       fat: lhs.fat / rhs,
                       calories: lhs.calories / rhs)
    }
    
    public static func +(lhs: Macronutrients, rhs: Macronutrients) -> Macronutrients {
        Macronutrients(protein: lhs.protein + rhs.protein,
                       carbohydrates: lhs.carbohydrates + rhs.carbohydrates,
                       fat: lhs.fat + rhs.fat,
                       calories: lhs.calories + rhs.calories)
    }
    
    internal static func zeroed() -> Macronutrients {
        Macronutrients(protein: 0, carbohydrates: 0, fat: 0, calories: 0)
    }
}

extension Macronutrients {
    var percentProtein: Double {
        get {
            self.protein/(self.carbohydrates + self.protein + self.fat * 2)
        }
    }
    var percentCarbs: Double {
        get {
            self.carbohydrates/(self.carbohydrates + self.protein + self.fat * 2)
        }
    }
    var percentFat: Double {
        get {
            (self.fat*2)/(self.carbohydrates + self.protein + self.fat * 2)
        }
    }
}
