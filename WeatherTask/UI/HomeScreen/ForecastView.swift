//
//  ForecastView.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation
import SwiftUI

struct ForecastView: View {
    var forecastData:ForecastResponse? = nil
    var body: some View {
        VStack(spacing: 15) {
            if let forecast = forecastData?.list{
                GetDailyAverages(list: forecast)
                ForEach(forecast.prefix(5),id: \.dt){ data in
                    DayForecastView(day: data.dt.getDayOFTheWeekFromTimeInterval(), high: "\(data.main.tempMax.toInt())°", low: "\(data.main.tempMin.toInt())°", icon: "\(data.weather[0].icon)", chanceOfRain: data.pop?.toInt())
                }
            }
        }.padding(.horizontal)
    }
    
    
    func GetDailyAverages(list:[List]) {
        
                var dailyData: [String: [Main]] = [:]
        
                // Group by day
                for forecast in list {
                    let date = String(forecast.dtTxt!.split(separator: " ")[0])
                    dailyData[date, default: []].append(forecast.main)
                }
        
                // Calculate averages
                let dailyAverages = dailyData.mapValues { data in
                    let summedData =  data.reduce(0, {partialResult,m in
                            return Main(
                                       temp: partialResult.temp + m.temp,
                                       feelsLike: partialResult.feelsLike + m.feelsLike,
                                       tempMin: partialResult.tempMin + m.tempMin,
                                       tempMax: partialResult.tempMax + m.tempMax,
                                       pressure: partialResult.pressure + m.pressure,
                                       seaLevel: partialResult.seaLevel + m.seaLevel,
                                       grndLevel: partialResult.grndLevel + m.grndLevel,
                                       humidity: partialResult.humidity + m.humidity)
                        })
                    let numOfItems = data.count
                    return Main(temp: summedData.temp/numOfItems,
                                feelsLike: summedData.feelsLike/numOfItems,
                                tempMin: summedData.tempMin/numOfItems,
                                tempMax: summedData.tempMax/numOfItems,
                                pressure: summedData.pressure/numOfItems,
                                seaLevel: summedData.seaLevel/numOfItems,
                                grndLevel: summedData.grndLevel/numOfItems,
                                humidity: summedData.humidity/numOfItems)
                    }
        print("zzzz",dailyAverages)
//        return dailyAverages
    }
}
