//
//  TrackMeApp.swift
//  TrackMe
//
//  Created by Jason Dees on 11/23/22.
//

import SwiftUI

@main
struct TrackMeApp: App {
    let persistenceController = PersistenceController.preview
    
    var body: some Scene {
        WindowGroup {
            let viewContext = persistenceController.container.viewContext
            let dayController = DayController(context: viewContext)
            let dayViewModel = DayViewModel(publisher: dayController.days.eraseToAnyPublisher())
            let foodController = FoodController(context: viewContext)
            let foodViewModel = FoodListViewModel(publisher: foodController.foods.eraseToAnyPublisher())
            MainTabView(dayViewModel: dayViewModel,
                        foodListViewModel: foodViewModel)
            .environment(\.managedObjectContext, viewContext)
        }
    }
}
