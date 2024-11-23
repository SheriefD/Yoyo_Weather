//
//  WeatherTaskApp.swift
//  WeatherTask
//
//  Created by Sherif on 21/11/2024.
//

import SwiftUI

@available(iOS 14.0, *)
@main
struct WeatherTaskApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appdelegate
    
    var body: some Scene {
        WindowGroup {
            GlobalAlertView(content:HomeView())
        }
    }
}
