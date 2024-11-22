//
//  Response2.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation

// MARK: - Welcome
struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}


// MARK: - List
struct List: Codable {    
    let dt: Double
    let main: Main
    let weather: [Weather]
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop
        case dtTxt = "dt_txt"
    }
}

