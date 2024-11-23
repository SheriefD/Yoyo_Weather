//
//  ForecastEntity.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation

//Todo: create protocols for common items
struct ForecastMainDataEntity {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double?
    var dt:Double
    var pop:Double?
    var icon:String
}
