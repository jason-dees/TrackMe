//
//  FoodListView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/24/22.
//

import SwiftUI

//https://stackoverflow.com/questions/58809357/swiftui-list-with-section-index-on-right-hand-side
struct FoodListView: View {
    
    @Environment(\.foodController) private var foodController
    @ObservedObject var viewModel: FoodListViewModel
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack {
                NavigationView {
                    List {
                        ForEach($viewModel.foodFirstLetters) { letterBinding in
                            let letter = letterBinding.wrappedValue
                            Section(header: Text(letter).id(letter)) {
                                ForEach($viewModel.filteredFoods.filter { $0.wrappedValue.food.name.uppercased().prefix(1) == letter }, id: \.id) { $food in
                                    NavigationLink(destination: FoodView(viewModel: FoodViewModel(food, foodController: foodController))){
                                        Text(food.food.name)
                                    }
                                    .swipeActions {
                                        Button(role: .destructive){
                                            deleteFood()
                                        } label: {
                                            Text("Delete")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Foods")
                .searchable(text: $viewModel.foodFilter,
                            placement: .navigationBarDrawer(displayMode: .always),
                            prompt: "Search foods")
                VStack {
                    ForEach(alphabet, id: \.self) { letter in
                        HStack {
                            Spacer()
                            Button(action: {
                                scrollProxy.scrollTo(letter)
                            }, label: {
                                Text(letter)
                                    .font(.system(size: 12))
                                    .padding(.trailing, 7)
                            })
                            .disabled(!$viewModel.foodFirstLetters.contains { $0.wrappedValue == letter })
                            
                        }
                    }
                }
            }
        }
    }
    
    func deleteFood() {}
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView(viewModel: FoodListViewModel(publisher: FoodController.preview.foods.eraseToAnyPublisher()))
    }
}
extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

extension Food: Identifiable {
    public typealias ID = UUID
}
