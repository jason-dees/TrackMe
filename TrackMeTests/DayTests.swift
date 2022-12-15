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
        let eaten = EatenFood(recipe: sandwich)
        XCTAssertEqual(eaten.name, sandwich.name)
        XCTAssertEqual(try eaten.macros, try sandwich.macros)
    }
    
    func testEatenFood() throws {
        let eaten = EatenFood(food: bread)
        XCTAssertEqual(eaten.name, bread.name)
        XCTAssertEqual(try eaten.macros, try bread.macros)
    }
    
    func testMealMacros() {
        let eatenBread = EatenFood(food: bread)
        let meal = Meal(name: "Lunch", eaten: [eatenBread])
        
        XCTAssertEqual(try meal.macros, try eatenBread.macros)
    }
    
    func testDayMacros() {
        let eatenBread = EatenFood(food: bread)
        let meal = Meal(name: "Lunch", eaten: [eatenBread])
        
        let day = Day(date: Date.now, meals: [meal], calorieLimit: 2000)
        
        XCTAssertEqual(try day.macros, try meal.macros)
        
    }
}
