//
//  FoodListView.swift
//  TrackMe
//
//  Created by Jason Dees on 12/24/22.
//

import SwiftUI

//https://stackoverflow.com/questions/58809357/swiftui-list-with-section-index-on-right-hand-side
struct FoodListView: View {
    @StateObject var viewModel: FoodListViewModel
    @State var searchText  = ""
    @State var currentLetter = ""
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack {
                NavigationView {
                    List {
                        ForEach(filteredAlphabet, id: \.self) { letter in
                            Section(header: Text(letter).id(letter)) {
                                ForEach(searchResults.filter { $0.name.prefix(1) == letter }, id: \.id) { food in
                                    NavigationLink(destination: Text(food.name)){
                                        Text(food.name)
                                    }
                                }
                            }
                        }
                        
                    }
                    .listStyle(.plain)
                    .navigationTitle("Foods")
                    .searchable(text: $searchText,
                                placement: .navigationBarDrawer(displayMode: .always),
                                prompt: "Search foods")
                }
                VStack {
                    ForEach(alphabet, id: \.self) { letter in
                        HStack {
                            Spacer()
                            if filteredAlphabet.contains { $0 == letter }{
                                Button(action: {
                                    print("letter = \(letter)")
                                    scrollProxy.scrollTo(letter)
                                }, label: {
                                    Text(letter)
                                        .font(.system(size: 12))
                                        .padding(.trailing, 7)
                                })
                            }
                            else {
                                Button(action: {
                                }, label: {
                                    Text(letter)
                                        .font(.system(size: 12))
                                        .padding(.trailing, 7)
                                }).disabled(true)
                            }
                        }
                    }
                }
            }
        }
    }
    var searchResults: [Food] {
        if searchText.isEmpty {
            return viewModel.foods
        } else {
            return viewModel.foods.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var filteredAlphabet: [String] {
        alphabet.filter { a in searchResults.contains { f in a == f.name.prefix(1)} }
    }
    
    func isSameLetter(_ foodName: String) -> Bool {
        if currentLetter != foodName.prefix(1) {
            currentLetter = String(foodName.prefix(1))
            return false
        }
        return true
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView(viewModel: FoodListViewModel(publisher: FoodController.preview.foods.eraseToAnyPublisher()))
    }
}
