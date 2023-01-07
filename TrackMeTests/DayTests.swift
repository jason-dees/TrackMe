//
//  DayTests.swift
//  TrackMeTests
//
//  Created by Jason Dees on 11/26/22.
//

import XCTest
import TrackMe

final class DayTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEatenRecipe() throws {
        let eaten = EatenFood(recipe: sandwich, measurement: .each(1.0))
        XCTAssertEqual(eaten.name, sandwich.name)
        XCTAssertEqual(eaten.macros, sandwich.macros * 0.2) // macros/5 != macros * 0.2
    }
    
    func testEatenFood() throws {
        let eaten = EatenFood(food: bread, measurement: .each(1.0))
        XCTAssertEqual(eaten.name, bread.name)
        XCTAssertEqual(eaten.macros, bread.macros(for: .each(1.0)))
    }
    
    func testMealMacros() {
        let eatenBread = EatenFood(food: bread, measurement: .each(1.0))
        let meal = Meal(name: "Lunch", eaten: [eatenBread, eatenBread])
        
        XCTAssertEqual(meal.macros, eatenBread.macros * 2)
    }
    
    func testDayMacros() {
        let eatenBread = EatenFood(food: bread, measurement: .each(1.0))
        let meal = Meal(name: "Lunch", eaten: [eatenBread])
        
        let day = Day(date: Date.now, meals: [meal], calorieLimit: 2000)
        
        XCTAssertEqual(day.macros, meal.macros)
        
    }
}
