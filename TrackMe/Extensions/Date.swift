//
//  Date.swift
//  TrackMe
//
//  Created by Jason Dees on 12/1/22.
//

import Foundation

extension Date {
    var medium: String {
        get {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: self)
        }
    }
}
