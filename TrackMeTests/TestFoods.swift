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
        let butterEdible = Edible(name: "butter", amounts: [butterMacroGrams, butterMacroTbsp, butterMacroCups])
        
        return Food(name: "Butter", edible: butterEdible, measurement: .grams(45))
    }
}

var bread: Food {
    get {
        let breadMacroEach = Amount(measurement: .each(2), macros: Macronutrients(protein: 3, carbohydrates: 20, fat: 2, calories: 150))
        let breadEdible = Edible(name: "bread", amounts: [breadMacroEach])
        
        return Food(name: "Bread", edible: breadEdible, measurement: .each(2))
    }
}

var sandwich: Recipe {
    get {
        Recipe(name: "Lots of butter", longDescription: "even more butter", totalQuantity: .each(5), ingredients: [butter, bread])
    }
}
