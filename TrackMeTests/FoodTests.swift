//
//  FoodTests.swift
//  TrackMeTests
//
//  Created by Jason Dees on 11/24/22.
//

import XCTest
import TrackMe

final class FoodTests: XCTestCase {

    
    func testFoodRelationships() {
        XCTAssertEqual(try butter.macros.calories, 150.0 * 3)
    }
    
    func testRecipeMacros() {
        XCTAssertEqual(try sandwich.macros.calories, try butter.macros.calories + bread.macros.calories)
    }
    
    func testRecipeFoodMacros() {
        let food = RecipeFood(recipe: sandwich, amount: .each(2))
        XCTAssertEqual(try food.macros.calories, try sandwich.macros.calories * 2/5)
    }
    
    func testRecipeFoodMacrosThrowsErrorWhenAmountMismatch() {
        let food = RecipeFood(recipe: sandwich, amount: .grams(200))
        XCTAssertThrowsError(try food.macros.calories)
    }
}
