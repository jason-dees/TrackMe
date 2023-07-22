//
//  MacrosView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/23/22.
//

import SwiftUI

struct MacrosView: View {
    @State var macros: Macronutrients
    var body: some View {
        VStack(spacing: 0) {
            if false {
                GeometryReader { metrics in
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(.green)
                            .frame(width: metrics.size.width * self.macros.percentProtein)
                            .overlay{
                                Text(String(format: "P %.0f", macros.protein))
                            }
                        Rectangle()
                            .fill(.cyan)
                            .frame(width: metrics.size.width * self.macros.percentCarbs)
                            .overlay{
                                Text(String(format: "C %.0f", macros.carbohydrates))
                            }
                        Rectangle()
                            .fill(.brown)
                            .frame(width: metrics.size.width * self.macros.percentFat)
                            .overlay{
                                Text(String(format: "F %.0f", macros.fat))
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                }
            }
            Text(String(format: "Protein %.0f", macros.protein))
            Text(String(format: "Carbs %.0f", macros.carbohydrates))
            Text(String(format: "Fat %.0f", macros.fat))
        }
    }
    
    func getWidth(m: Double, macros: Macronutrients) -> Double {
        return m/(macros.protein + macros.carbohydrates + macros.fat*2)
    }
}

struct MacroView_Previews: PreviewProvider {
    static var previews: some View {
        let day = DayViewModel(publisher: DayController.preview.days.eraseToAnyPublisher()).today
        
        MacrosView(macros: day.meals.first?.macros ?? Macronutrients())
    }
}
