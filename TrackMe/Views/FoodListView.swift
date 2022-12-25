//
//  FoodListView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/24/22.
//

import SwiftUI

struct FoodListView: View {
    @StateObject var viewModel: FoodListViewModel
    @State var searchText  = ""
    
    var body: some View {
        NavigationView{
            List {
                ForEach(viewModel.foods, id: \.id) { food in
                    HStack {
                        Image(systemName: food.icon)
                        Text(food.name)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Foods")
        }
        .searchable(text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search foods")
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView(viewModel: FoodListViewModel(publisher: FoodController.preview.foods.eraseToAnyPublisher()))
    }
}
