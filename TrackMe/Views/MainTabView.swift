//
//  DayView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/1/22.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel: DayViewModel
    var body: some View {
        TabView {
            DayView(day: viewModel.today)
                .badge(0)
                .tabItem {
                    Label("Day", systemImage: "calendar")
                }
            Text("some other view")
                .badge(0)
                .tabItem {
                    Label("Foods", systemImage: "carrot")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(viewModel: DayViewModel(dayPublisher: DayController.preview.days.eraseToAnyPublisher()))
    }
}
