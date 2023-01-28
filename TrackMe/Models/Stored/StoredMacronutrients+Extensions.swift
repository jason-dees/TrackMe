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
        self.id = UUID()
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
    
    public var uiProtein: String {
        get {
            String(self.protein)
        }
        set {
            if let newDouble = Double(newValue) {
                self.protein = newDouble
            }
            else {
                self.protein = 0
            }
        }
    }
    
    public var uiCarbohydrates: String {
        get {
            String(self.carbohydrates)
        }
        set {
            if let newDouble = Double(newValue) {
                self.carbohydrates = newDouble
            }
            else {
                self.carbohydrates = 0
            }
        }
    }
    
    public var uiFat: String {
        get {
            String(self.fat)
        }
        set {
            if let newDouble = Double(newValue) {
                self.fat = newDouble
            }
            else {
                self.fat = 0
            }
        }
    }
    
    public var uiCalories: String {
        get {
            String(self.calories)
        }
        set {
            if let newDouble = Double(newValue) {
                self.calories = newDouble
            }
            else {
                self.calories = 0
            }
        }
    }
}

