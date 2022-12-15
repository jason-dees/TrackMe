//
//  StoredMacronutrients+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/13/22.
//

import Foundation

extension StoredMacronutrients {
    var macronutrients: Macronutrients {
        get {
            Macronutrients(protein: self.protein, carbohydrates: self.carbohydrates, fat: self.fat, calories: self.calories)
        }
    }
}
