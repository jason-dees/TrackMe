//
//  FoodListView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/24/22.
//

import SwiftUI

struct FoodListView: View {
    @StateObject var viewModel: FoodListViewModel
    
    var body: some View {
        VStack{
            Text("Foods")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background {
                    Rectangle()
                        .fill(.white)
                }
            List {
                ForEach(viewModel.foods, id: \.id) { food in
                    Text(food.name)
                }
            }.listStyle(.grouped)
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView(viewModel: FoodListViewModel(publisher: FoodController.preview.foods.eraseToAnyPublisher()))
    }
}
