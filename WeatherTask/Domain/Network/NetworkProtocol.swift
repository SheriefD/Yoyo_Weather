////
////  NetworkProtocol.swift
////  WeatherTask
////
////  Created by Sherif on 21/11/2024.
///
///
import Foundation
protocol NetworkProtocol {
    func loadForecastData(lat:CGFloat?,lng: CGFloat?,completion:@escaping (ForecastResponse?) -> ())
    func loadWeatherData(lat:CGFloat?,lng: CGFloat?,completion:@escaping (CurrentWeatherResponse?) -> ())
}
