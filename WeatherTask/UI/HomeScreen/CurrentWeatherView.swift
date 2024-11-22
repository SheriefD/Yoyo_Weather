//
//  CurrentWeatherView.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation
import SwiftUI

struct CurrentWeatherView : View {
    
    var locationNameTitle :String? = "South Africa"
    var locationName:String = ""
    var temperatureNow:String = ""
    var weatherDescription:String = ""
    var tempMin:String = ""
    var tempMax:String = ""
    var feelsLike:String = ""
    var windspeed:String = ""
    var humidity:String  = ""
    
    init(_ locationName: String?, _ temp:CGFloat,_ desc:String? ,_ minTemp:CGFloat?,_ maxTemp:CGFloat?,_ feelsLike:CGFloat? , _ windspeed:CGFloat?,_ humidity:Int) {
        self.locationName = locationName ?? ""
        self.temperatureNow = "\(temp.toInt())"
        self.weatherDescription = desc ?? ""
        self.tempMin = "\(minTemp?.toInt() ?? 0)"
        self.tempMax = "\(maxTemp?.toInt() ?? 0)"
        self.feelsLike = "\(feelsLike?.toInt() ?? 0)"
        self.windspeed = "\(windspeed?.toInt() ?? 0)"
        self.humidity = "\(humidity ?? 0)"
        }
    
    var body: some View {
        VStack{
        HStack{Text(locationNameTitle!)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Image(systemName: "magnifyingglass.circle.fill").resizable().aspectRatio( contentMode: .fit).padding(.leading,8).colorInvert().frame(width: 45)
        }
        Text("\(temperatureNow)°")
            .font(.system(size: 90, weight: .thin))
            .foregroundColor(.white)
        
        Text(weatherDescription)
            .font(.system(size: 25))
            .foregroundColor(.white.opacity(0.9))
        
        Text("H:\(tempMax)°  L:\(tempMin)°")
            .font(.system(size: 20))
            .foregroundColor(.white)
    }.padding(.top,78)
    
    // Weather Details:-
    VStack(alignment: .leading, spacing: 5) {
        Text("\(locationName): \(weatherDescription) ,feels like :\(feelsLike) with \(humidity)% Humidity and wind speed ~\(windspeed)")
            .font(.system(size: 18))
            .foregroundColor(.white)
            .padding(.horizontal)
            .multilineTextAlignment(.leading)
    }
}
}
