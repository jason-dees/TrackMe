//
//  StoredRecipe+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/23/22.
//

import Foundation

extension StoredRecipe {
    
    public var ingredientsArray: [StoredFood] {
        get {
            self.ingredients?.allObjects as? [StoredFood] ?? []
        }
    }
    
    public var recipe: Recipe {
        get {
            Recipe(name: self.name ?? "Unknown Recipe",
                   longDescription: self.longDescription ?? "This is a default value due to an unknown recipe",
                   totalQuantity: self.totalQuantity?.measurement ?? Measurement.defaultValue,
                   ingredients: self.ingredientsArray.map { $0.food })
        }
    }
}
