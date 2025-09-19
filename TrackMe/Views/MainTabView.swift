//
//  DayView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/1/22.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var dayViewModel: DayViewModel
    @ObservedObject var foodListViewModel: FoodListViewModel
    
    var body: some View {
        TabView {
            FoodListView(viewModel: foodListViewModel)
                .badge(0)
                .tabItem {
                    Label("Foods", systemImage: "carrot")
                }
            
            DayView(day: dayViewModel.today)
                .badge(0)
                .tabItem {
                    Label("Day", systemImage: "calendar")
                }
        }
        .onAppear {
        }
        
    }
    
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(dayViewModel: DayViewModel(publisher: DayController.preview.days.eraseToAnyPublisher()),
                    foodListViewModel: FoodListViewModel(publisher: FoodController.preview.foods.eraseToAnyPublisher())
        )
    }
}
