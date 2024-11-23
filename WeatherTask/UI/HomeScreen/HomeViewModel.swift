//
//  HomeViewModel.swift
//  WeatherTask
//
//  Created by Sherif on 23/11/2024.
//

import Foundation
import CoreLocation
class HomeViewModel:ObservableObject {
    private let locationManager = LocationManager.shared
    private let repo:WeatherRepo = WeatherRepo(dataSource: Network.shared)
    @Published var weatherData:CurrentWeatherResponse? = nil
    @Published var forecastData:ForecastResponse? = nil
    @Published var viewState: ViewState = .idle

    
    func checkLocationAuth() {
        locationManager.checkLocationAuthorization()
    }
    
    func refreshData() {
        
        if let location = locationManager.lastKnownLocation {
            getCurrentWeatherData(loc: location)
            getForecastWeatherData(loc: location)
        } else
        {
            viewState = .loading
            repo.loadWeatherData(completion: { r in
                self.viewState = .success(nil)
                self.weatherData = r }
            )
            repo.loadForecastData(completion: {r in
                self.viewState = .success(nil)
                self.forecastData = r
            })}
    }
    
    
    func getCurrentWeatherData(loc:CLLocationCoordinate2D) {
        viewState = .loading
        repo.loadWeatherData(lat:loc.latitude,lng: loc.longitude, completion: { r in
            self.viewState = .success(nil)
            self.weatherData = r }
        )
    }
    
    func getForecastWeatherData(loc:CLLocationCoordinate2D) {
        viewState = .loading
        repo.loadForecastData(lat:loc.latitude,lng: loc.longitude, completion: { r in
            self.viewState = .success(nil)
            self.forecastData = r }
        )
    }
}
