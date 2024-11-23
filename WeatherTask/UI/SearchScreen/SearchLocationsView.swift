//
//  SearchLocationsView.swift
//  WeatherTask
//
//  Created by Sherif on 23/11/2024.
//

import Foundation
import CoreLocation
import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    var onSearchComplete: (String,CLLocationCoordinate2D?) -> Void
    @State private var searchText: String = ""
    @StateObject private var viewModel = SearchLocationViewModel()

    var body: some View {
            VStack() {
                
                TextField("Enter your City , Country",/* text: $searchText*/ text: Binding(
                    get: { searchText },
                    set: { newValue in
                        searchText = newValue
                        viewModel.debounceSearch(query: newValue)
                    }
                )).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // List of Results
               
                ZStack{
                    if viewModel.viewState == .loading {
                        VStack(alignment: .center){
                            Spacer()
                            ActivityIndicator(isAnimating: .constant(true), style: .large)
                            Spacer()
                        }
                    }
                ScrollView {
                  
                        VStack(alignment: .leading, spacing: 10) {
                            
                            
                            
                            
                            ForEach(viewModel.searchResults, id: \.self) { item in
                                Text(viewModel.formatAddress(add:item))
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        onSearchComplete(searchText,item.location?.coordinate )
                                        presentationMode.wrappedValue.dismiss()
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)}
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Exit")
                        .frame(maxWidth: .infinity,maxHeight:45)
                }.padding([.leading,.trailing],25)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }.padding().background(
                Image("bg").resizable().aspectRatio(contentMode: .fill)).edgesIgnoringSafeArea([.leading,.trailing])
    }
}
