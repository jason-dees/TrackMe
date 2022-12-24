//
//  StoredIngredient+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/24/22.
//

import Foundation

extension StoredIngredient {
    
    public var ingredient: Ingredient {
        get {
            Ingredient(food: self.food?.food ?? Food(), measurement: self.measurement?.measurement ?? Measurement.defaultValue)
        }
    }
    
}
