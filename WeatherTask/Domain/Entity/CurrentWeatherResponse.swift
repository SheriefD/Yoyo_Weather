//
//  CurrentWeatherResponse.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation
struct CurrentWeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind?
    let clouds: Clouds?
    let dt: Double?
    let timezone, id: Int
    let name: String
    let cod: Int
}
