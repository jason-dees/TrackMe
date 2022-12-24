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
            List {
                ForEach(day.meals, id: \.self.id){ meal in
                    MealView(meal: meal).listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
        }
    }
    
    func addFood() {
        
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        let day = DayViewModel(publisher: DayController.preview.days.eraseToAnyPublisher()).today
        DayView(day: day)
    }
}
