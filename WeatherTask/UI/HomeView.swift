//
//  ContentView.swift
//  WeatherTask
//
//  Created by Sherif on 21/11/2024.
//

import SwiftUI
import CoreLocation
    
struct HomeView:View {
//    @StateObject private var currentCoord:CLLocationCoordinate2D?
    @StateObject private var locationManager = LocationManager()
    @State var weatherData:CurrentWeatherResponse? = nil
    @State var forecastData:ForecastResponse? = nil
    
    var body: some View {
        ZStack{
            // Background:-
            BackgroundView()
            // Background-end
            
            VStack(spacing: 20) {
                // Location and Temperature
                VStack(spacing: 5) {
                    VStack {
//                        if let coordinate = locationManager.lastKnownLocation {
//                            //                        currentCoord = coordinate
//                            //                            Text("Latitude: \(coordinate.latitude)")
//                            //                            Text("Longitude: \(coordinate.longitude)")
//                        } else {
//                            //                            Text("Unknown Location").foregroundColor(.white)
//                        }
                        
                        Button("Get current location") {
                            locationManager.checkLocationAuthorization()
                        }
                    }.padding(0)
                    
                    if let data = weatherData, let main = weatherData?.main {
                        CurrentWeatherView(data.name,
                                           main.temp, data.weather.first?.description ?? "N/A", main.tempMin, main.tempMax,
                                           main.feelsLike, data.wind?.speed ?? 0.0, main.humidity)
                       
                    } else {
                        CurrentWeatherView("-----",0.0,"...Loading...",0.0,0.0,0.0,0.0,0).edgesIgnoringSafeArea(.all)
//                            .shimmer().opacity(1)
                    }
                }
                
                // 5-Day Forecast
                VStack(alignment: .leading, spacing: 10) {
                    Text("5-DAY FORECAST")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.horizontal)
                    ForecastView(forecastData: forecastData)
                }
                
                Spacer()
            }
            ActivityIndicator(isAnimating: .constant(true), style: .large)
        }.onAppear(){
                            NetworkCall().loadWeatherData() { r in
                                self.weatherData = r
                                print("Response data = \(r)")
                            }
            NetworkCall().loadForecastData() { r in
                self.forecastData = r
                print("Response Forecast data = \(r)")
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




struct CustomProgressView: View {
  let progress: CGFloat

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle()
          .frame(width: geometry.size.width, height: 5)
          .opacity(0.3)
          .foregroundColor(.gray)

        Rectangle()
          .frame(
            width: min(progress * geometry.size.width,
                       geometry.size.width),
            height: 10
          )
          .foregroundColor(.blue)
      }
    }
  }
}

//
//struct HomeView: View {
//    var body: some View {
//        ZStack{
//            Color.purple.edgesIgnoringSafeArea(.all)
//
//            VStack(spacing: 0) {
//                Text("California").font(.system(size: 60,weight: .bold,design: .serif))
//
//                HStack(alignment: .top){
//                    Text("21").font(.system(size: 60,weight: .medium,design: .rounded)).frame(alignment: .topLeading).background(Color.clear)
//
//                    Text("o").font(.system(size: 20,weight: .heavy,design: .rounded)).background(Color.clear).padding(.vertical, 10)
//                }
////                Image(systemName: "globe")
////                    .imageScale(.large)
////                    .foregroundColor(.accentColor)
////                Text("Hello, MY world!")
//            }
//            .padding()
////            VStack {
////
////                Image(systemName: "globe")
////                    .imageScale(.large)
////                    .foregroundColor(.accentColor)
////                Text("Hello, MY world!")
////            }
////            .padding()
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}



///TITLE  37  center
///Temperature 104 (Text)   Text for (C or F )
///Desc : (cloudy )  24
///High / low 21
///
///
///collapse when scrolling up to location
///degrees | description
///
///
///
///
///SECTION : Now +4hrs   icon + degree
///
///

//get the current device location and if user doesn't provide consent ask again when the user click on same item
//Fetch details based on current location

// show loading indicator : UIActivityIndicatorView till UI is loaded

// create a generic network error in case of network errors

// Use URL task manager
