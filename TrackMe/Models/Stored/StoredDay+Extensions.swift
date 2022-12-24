//
//  StoredDay+Extensions.swift
//  TrackMe
//
//  Created by Jason Dees on 12/15/22.
//

import CoreData
import Foundation

extension StoredDay {
    public convenience init(context moc: NSManagedObjectContext, date: Date, meals: [StoredMeal], calorieLimit: Int) {
        self.init(context: moc)
        self.id = UUID()
        self.date = date
        self.meals = Set(meals) as NSSet
        self.calorieLimit = Int32(calorieLimit)
    }
    
    public var mealsArray: [StoredMeal] {
        get {
            (self.meals?.allObjects as? [StoredMeal] ?? []).sorted { $0.order < $1.order }
        }
    }
    
    public var day: Day {
        get {
            Day(date: self.date ?? Date.now,
                meals: self.mealsArray.map { $0.meal },
                calorieLimit: Int(self.calorieLimit))
        }
    }
}
