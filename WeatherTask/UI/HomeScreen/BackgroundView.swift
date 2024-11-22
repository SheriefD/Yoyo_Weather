//
//  BackgroundView.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation
import SwiftUI

struct BackgroundView : View {
    
    var currentWeather :WeatherConditions = .cloudy
    
    var body: some View {
    
    Image("bg").resizable().aspectRatio(contentMode:.fill).edgesIgnoringSafeArea(.all)
    
    VStack {
        ZStack{
            Image("galaxy").resizable()
                .aspectRatio(contentMode:.fit).edgesIgnoringSafeArea(.all)
            switch currentWeather {
            default:
                Image("cloudy").resizable()
                    .aspectRatio(contentMode:.fit).edgesIgnoringSafeArea(.all)
            }
        }.edgesIgnoringSafeArea(.all)
        Spacer()
    }
    // gradient color (hidden)
    LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue.opacity(0.8)]),
                   startPoint: .top, endPoint: .bottom)
    .edgesIgnoringSafeArea(.all).hidden()
 }
}
