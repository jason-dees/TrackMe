//
//  TrackMeApp.swift
//  TrackMe
//
//  Created by Jason Dees on 11/23/22.
//

import SwiftUI

@main
struct TrackMeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
