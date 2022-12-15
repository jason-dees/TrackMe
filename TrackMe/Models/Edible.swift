//
//  Edible.swift
//  TrackMe
//
//  Created by Jason Dees on 12/12/22.
//

import Foundation


public struct Edible { // Item data
    public let name: String
    public let amounts: [Amount] // A measurements can have differing macro amounts
    
    public init(name: String, amounts: [Amount]) {
        self.name = name
        self.amounts = amounts
    }
}
