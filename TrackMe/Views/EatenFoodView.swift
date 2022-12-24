//
//  EatenView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/24/22.
//

import Foundation

import SwiftUI

struct EatenFoodView: View {
    @State var eatenFood: EatenFood
    var body: some View {
        VStack {
            HStack {
                Text(eatenFood.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
//                Button(action: removeEatenFood){
//                    Image(systemName: "pencil")
//                }
//                .padding(10)
//                Button(action: removeEatenFood){
//                    Image(systemName: "minus")
//
//                }
//                .padding(10)
            }
            .font(.headline)
            MacrosView(macros: eatenFood.macros)
                .frame(height: 50.0)
        }
    }
    
    private func removeEatenFood() {
        
    }
}
