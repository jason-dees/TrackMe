//
//  StoredMeal+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/15/22.
//

import CoreData
import Foundation

extension StoredMeal {
    public convenience init(context moc: NSManagedObjectContext, name: String, order: Int, eatenFoods: [StoredEatenFood]) {
        self.init(context: moc)
        self.name = name
        self.order = Int16(order)
        self.eatenFoods = Set(eatenFoods) as NSSet
    }
    
    public var eatenFoodsArray: [StoredEatenFood] {
        get {
            (self.eatenFoods?.allObjects as? [StoredEatenFood] ?? []).sorted { $0.order < $1.order }
        }
    }
    
    public var macros: StoredMacronutrients? {
        get {
            //StoredMacronutrients(protein: 0.0, carbohydrates: 0.0, fat: 0.0, calories: 0)
            nil
        }
    }
    
    public var meal: Meal {
        get {
            Meal(name: self.name ?? "Unknown Meal Name",
                 eaten: self.eatenFoodsArray.map { $0.eatenFood })
        }
    }
}
