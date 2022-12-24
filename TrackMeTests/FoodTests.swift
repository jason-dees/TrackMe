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
        XCTAssertEqual(butter.macros.calories, 150.0 * 3)
    }
    
    func testRecipeMacros() {
        XCTAssertEqual(sandwich.macros.calories, butter.macros.calories + bread.macros.calories)
    }
}
