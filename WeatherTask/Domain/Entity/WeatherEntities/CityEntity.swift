//
//  Weather.swift
//  WeatherTask
//
//  Created by Sherif on 21/11/2024.
//

import Foundation
// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int?
}
