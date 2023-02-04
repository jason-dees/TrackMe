//
//  NumberFormatter.swift
//  TrackMe
//
//  Created by Jason Dees on 2/1/23.
//

import Foundation

private var numberFormatter = NumberFormatter()

extension NumberFormatter {
    
    static func formatString(_ value: Double, maxFractionDigits: Int = 10) -> String {
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = maxFractionDigits
        return numberFormatter.string(from: value as NSNumber) ?? "??.??"
    }
}
