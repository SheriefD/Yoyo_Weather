//
//  CurrentWeatherView.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation
import SwiftUI
import CoreLocation

struct GetLocationButtonView : View {
    let viewModel:HomeViewModel? = nil
    @StateObject private var locationManager = LocationManager.shared
    @State private var showPermissionAlert = false
    let action: () -> Void
    
    var body: some View {
        Button("Get current location") {
                action()
                locationManager.checkLocationAuthorization()
        }.padding(.top,50)
        }
    }

