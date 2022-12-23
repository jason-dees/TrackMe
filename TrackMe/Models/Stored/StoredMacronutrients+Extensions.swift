//
//  StoredMacronutrients+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/13/22.
//

import CoreData
import Foundation

extension StoredMacronutrients {
    public convenience init(context moc: NSManagedObjectContext, protein: Double, carbohydrates: Double, fat: Double, calories: Double) {
        self.init(context: moc)
        self.protein = protein
        self.carbohydrates = carbohydrates
        self.fat = fat
        self.calories = calories
    }
    
    public var macros: Macronutrients {
        get {
            Macronutrients(protein: self.protein ,
                           carbohydrates: self.carbohydrates ,
                           fat: self.fat ,
                           calories: self.calories )
        }
    }
}
