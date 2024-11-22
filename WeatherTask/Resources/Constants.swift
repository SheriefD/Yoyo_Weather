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


