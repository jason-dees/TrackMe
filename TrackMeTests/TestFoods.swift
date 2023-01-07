//
//  TestFoods.swift
//  TrackMeTests
//
//  Created by Jason Dees on 11/26/22.
//

import Foundation
import TrackMe

var butter: Food {
    get {
        let butterMacroGrams = Amount(measurement: .grams(15.0), macros: Macronutrients(protein: 1, carbohydrates: 2, fat: 8, calories: 150))
        let butterMacroTbsp = Amount(measurement: .tbsp(1.0), macros: Macronutrients(protein: 1, carbohydrates: 2, fat: 8, calories: 150))
        let butterMacroCups = Amount(measurement: .cups(0.0625), macros: Macronutrients(protein: 1, carbohydrates: 2, fat: 8, calories: 150))
        return Food(id: UUID(), name: "butter", amounts: [butterMacroGrams, butterMacroTbsp, butterMacroCups])
    }
}

var bread: Food {
    get {
        let breadMacroEach = Amount(measurement: .each(2), macros: Macronutrients(protein: 3, carbohydrates: 20, fat: 2, calories: 150))
        return Food(id: UUID(), name: "bread", amounts: [breadMacroEach])
    }
}

var sandwich: Recipe {
    get {
        let butterIngredient = Ingredient(food: butter, measurement: .grams(45))
        let breadIngredient = Ingredient(food: bread, measurement: .each(2))
        return Recipe(name: "Lots of butter", longDescription: "even more butter", totalQuantity: .each(5), ingredients: [butterIngredient, breadIngredient])
    }
}
