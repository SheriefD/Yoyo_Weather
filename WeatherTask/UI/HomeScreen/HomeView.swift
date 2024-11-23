//
//  ContentView.swift
//  WeatherTask
//
//  Created by Sherif on 21/11/2024.
//

import SwiftUI
import CoreLocation

struct HomeView:View {
    @StateObject private var locationManager = LocationManager.shared
    @State private var showPermissionAlert = false
    @State var currentLocation:CLLocationCoordinate2D? = nil
//    @State var weatherData:CurrentWeatherResponse? = nil
//    @State var forecastData:ForecastResponse? = nil
    @State private var isSearchPresented = false
    @State private var searchResult: String = ""
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack{
            // Background:-
            BackgroundView()
            // Background-end
            
            VStack(spacing: 20) {
                GetLocationButtonView(action:{
                    //TODO: viewmodel.refreshlocation
                    
                    if let location = locationManager.lastKnownLocation {
                        
                        viewModel.getCurrentWeatherData(loc: location)
                        
                        viewModel.getForecastWeatherData(loc: location)
                        
                    }
                }
                )
                
                // Location and Temperature
                if let data = viewModel.weatherData, let main = data.main{
                    CurrentWeatherView(data.name,
                                       main.temp, data.weather.first?.description ?? "N/A", main.tempMin, main.tempMax,
                                       main.feelsLike, data.wind?.speed ?? 0.0, main.humidity,{isSearchPresented = true })
                } else {
                    CurrentWeatherView("-----",0.0,"...Loading...",0.0,0.0,0.0,0.0,0,{isSearchPresented = true }).edgesIgnoringSafeArea(.all).shimmer().opacity(1)
                    //
                }
                
                
                // 5-Day Forecast
                VStack(alignment: .leading, spacing: 10) {
                    Text("5-DAY FORECAST")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.horizontal)
                    ZStack {
                        
                        ForecastView(forecastData: viewModel.forecastData)
                    }
                }
                
                Spacer()
            }
            VStack{
                if viewModel.viewState == .loading {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
            }
            
            
        }.onAppear(){
            viewModel.refreshData()
        }.sheet(isPresented: $isSearchPresented) {
            SearchView { result,coord in
                self.searchResult = result
                if let lat = coord?.latitude,let lng = coord?.longitude {
                    viewModel.getForecastWeatherData(loc: coord!)
                    viewModel.getCurrentWeatherData(loc: coord!)
                }
            }
        }
    }
}

    // Preview
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
