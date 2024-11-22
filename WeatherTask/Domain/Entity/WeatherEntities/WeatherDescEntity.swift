//
//  Weather.swift
//  WeatherTask
//
//  Created by Sherif on 21/11/2024.
//

import Foundation

// MARK: - Weather
struct Weather: Codable,Identifiable {
    let id: Int
    let main, description, icon: String
}
