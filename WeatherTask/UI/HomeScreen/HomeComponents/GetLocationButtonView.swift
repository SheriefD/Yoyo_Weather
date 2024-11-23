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
            if showPermissionAlert == true {
                GlobalAlertManager.shared.triggerAlert(title: "OPSSY", message: "ERROR VIEWWW")
            } else {
                action()
                locationManager.checkLocationAuthorization()
                
            }
        }.padding(.top,50).onAppear {
            if locationManager.showPermissionDeniedAlert {
                GlobalAlertManager.shared.triggerAlert(title: "OPSSY", message: "ERROR VIEWWW")
//                showPermissionAlert = true
            }
        }
    }
}
