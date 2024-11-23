//
//  ErrorView.swift
//  WeatherTask
//
//  Created by Sherif on 21/11/2024.
//

import Foundation
import SwiftUI

enum ErrorType {
    case decoding
    case noInternet
    case backend(Int)
}

struct ErrorView: View {
    
    let error: ErrorType
    
    var body: some View {
        VStack {
            Text("Something went wrong")
                .font(.title)
                .padding()
            Group {
                switch error {
                case .decoding:
                    Text("Error handling network response , check support")
                case .noInternet:
                    Text("Please check your internet connection and try again")
                case .backend(let code):
                    switch code {
                    case 401:
                        Text("Unauthorized access , check API key")
                    case 503:
                        Text("Service unavailable")
                    case 500 :
                        Text("Internal server error")
                    default:
                        Text("Server error code: \(code)")
                    }
                }
            }
            .padding()
        }
    }
}
