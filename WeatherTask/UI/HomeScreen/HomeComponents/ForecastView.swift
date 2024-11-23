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
               let data = GetDailyAverages(list: forecast)
                ForEach(data,id: \.0){ data in
                    DayForecastView(day: data.1.dt.getDayOFTheWeekFromTimeInterval(), high: "\(data.1.tempMax.toInt())°", low: "\(data.1.tempMin.toInt())°", icon: "\(data.1.icon)", chanceOfRain: data.1.pop?.toInt())
                }
            }
        }.padding(.horizontal)
    }
    var tempOverallMin = 0.0
    var tempOverallMax = 0.0
    
    func sumData(mData:[List]) -> ForecastMainDataEntity {
        
        let avgForecastEntity = mData.reduce( ForecastMainDataEntity(temp: 0.0,feelsLike: 0.0,tempMin: 0.0,tempMax: 0.0,pressure: 0,seaLevel: 0,grndLevel: 0,humidity: 0, tempKf:nil,dt:0.0,pop:0.0,icon: ""), {partialResult,m in
            return
          ForecastMainDataEntity(temp: partialResult.temp + m.main.temp,
                                 feelsLike: partialResult.feelsLike+m.main.feelsLike,
                                 tempMin: partialResult.tempMin+m.main.tempMin,
                                 tempMax: partialResult.tempMax+m.main.tempMax,
                                 pressure:partialResult.pressure+m.main.pressure,
                                 seaLevel: m.main.seaLevel,
                                 grndLevel:m.main.grndLevel,
                                 humidity: partialResult.humidity+m.main.humidity,
                                 tempKf:nil,
                                 dt:m.dt,
                                 pop:m.pop,
                                 icon: m.weather[0].icon)
           })
        return avgForecastEntity
    }
    
    func GetDailyAverages(list:[List]) -> [(String,ForecastMainDataEntity)] {
        
                var dailyData: [String: [List]] = [:]
                // Group by day
                for forecastItem in list {
//                    To be used in case of using date string
                    let date = String(forecastItem.dtTxt!.split(separator: " ")[0])
//                    let dateInterval = forecastItem.dt
                    dailyData[date, default: []].append(forecastItem)
                }
        
                // Calculate averages
        let dailyAverages = dailyData.mapValues {data in
            let itemsCount = data.count
            let summedData = sumData(mData:data)
            return ForecastMainDataEntity(temp: summedData.temp/Double(itemsCount),
                        feelsLike: summedData.feelsLike/Double(itemsCount),
                        tempMin: summedData.tempMin/Double(itemsCount),
                        tempMax: summedData.tempMax/Double(itemsCount),
                        pressure: summedData.pressure/itemsCount,
                        seaLevel: summedData.seaLevel/itemsCount,
                        grndLevel: summedData.grndLevel/itemsCount,
                        humidity: summedData.humidity/itemsCount,
                        tempKf: nil,
                        dt:summedData.dt,
                       pop:summedData.pop,
                       icon:summedData.icon
            )
        }
        
        // Sort dictionary data by date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = dailyAverages.sorted {
            formatter.date(from: $0.0)! < formatter.date(from: $1.0)!
        }
        
        return result
    }
}
