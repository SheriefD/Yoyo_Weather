//
//  Constants.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation

struct Const {
    
    struct Api {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apikeyVal = Bundle.main.infoDictionary?["WeatherApiKey"] as? String ?? ""
        //keys
        static let latkey = "lat"
        static let lngkey = "lon"
        static let apikey = "appid"
        static let unitsKey = "units"
        static let unitsMetricVal = "metric"
        static let numOfDaysKey = "cnt"
    }
    struct AppConstants {
        //SA default location
        static let defaultLat:CGFloat = -33.9221
        static let defaultLng :CGFloat = 18.4231
    }
}

enum WeatherConditions {
    case sunny
    case cloudy
    case rainy
}

enum ViewState {
    case idle
    case loading
    case success(Any?) // Result for success with generic Success and Failure types
    case failure
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.success(let leftData), .success(let rightData)):
            return true
        case (.failure, .failure):
            return true
            //                  return leftError.localizedDescription == rightError.localizedDescription
        default:
            return false
        }
    }
}
//enum ViewState<T>: Equatable where T: Equatable {
//    case idle
//    case loading
//    case result(T)
//

////    }
//}


