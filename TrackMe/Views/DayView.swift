//
//  DayView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/12/22.
//

import SwiftUI

struct DayView: View {
    @State var day: Day
    var body: some View {
        VStack{
            Text(day.date.medium)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background {
                    Rectangle()
                        .fill(.white)
                }
            ScrollView {
                ForEach(day.meals, id: \.self.id){ meal in
                    MealView(meal: meal)
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 5.0, style: .circular)
                                .fill(.white)
                                .shadow(color: .blue, radius: 1, x: 0, y: 0)
                                .padding(10)
                        }
                }
            }
        }
    }
    
    func addFood() {
        
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        let day = DayViewModel(dayPublisher: DayController.preview.days.eraseToAnyPublisher()).today
        DayView(day: day)
    }
}
