//
//  DayForecastView.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation
import SwiftUI

struct DayForecastView: View {
    var day: String
    var high: String
    var low: String
    var icon: String
    var iconColor:Color = .white
    var chanceOfRain: Int?
    var progress:CGFloat = 0
    @State private var speed = 50.0

    
    var body: some View {
        HStack {
            Text(day)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack{
//                Image(systemName: icon)
//                  .font(.system(size: 25))
//                  .foregroundColor(.white)
//                  .frame(width: 30)
//                Image(systemName: icon) //use image assets instead
                Image(icon).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 35)
                
                if let chance = chanceOfRain ,chance != 0 {
                    Text("\(chance)%")
                        .font(.subheadline)
                        .foregroundColor( Color(red: 129 / 255, green: 207 / 255, blue: 250 / 255))
                }
            }
          
            Spacer()
            HStack{
                Text("\(low)").font(.system(size: 22))
                    .foregroundColor(.white.opacity(0.6))
                
                ZStack{
//                        GeometryReader { proxy in
                        LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(1), Color.red]), startPoint: .leading, endPoint: .trailing)
                            .frame(height: 5)
                            .edgesIgnoringSafeArea(.all)
                        
                        Rectangle().frame(width: min(100, 100), height: 5)}.coordinateSpace(name: "ccc")
//                    }.frame(height: 5)
//                    Rectangle().frame(width: min(progress * geometry.size.width,y.size.width),
//                                                    height: 10
//                                                )
//                    ZStack{
//                        GeometryReader { geometry in
//
//
//                        }
//                        Rectangle()
//                            .frame(
//                                width: min(progress * geometry.size.width,
//                                           geometry.size.width),
//                                height: 10
//                            )
//                    }
                
                
                Text("\(high)")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
            }.padding(.leading,30)
        }
    }
}
