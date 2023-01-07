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
    
    // https://developer.apple.com/documentation/swiftui/restoring_your_app_s_state_with_swiftui
    var body: some Scene {
        WindowGroup {
            let viewContext = persistenceController.container.viewContext
            let dayViewModel = DayViewModel(publisher: DayController.shared.days.eraseToAnyPublisher())
            let foodViewModel = FoodListViewModel(publisher: FoodController.shared.foods.eraseToAnyPublisher())
            MainTabView(dayViewModel: dayViewModel,
                        foodListViewModel: foodViewModel)
            .environment(\.managedObjectContext, viewContext)
            .environment(\.foodController, FoodController.shared)
        }
    }
}

private struct FoodControllerKey: EnvironmentKey {
    static let defaultValue: FoodController = FoodController()
}
extension EnvironmentValues {
    var foodController: FoodController {
        get { self[FoodControllerKey.self] }
        set { self[FoodControllerKey.self] = newValue }
    }
}
