//
//  LocationManager.swift
//  WeatherTask
//
//  Created by Sherif on 21/11/2024.
//

import Foundation
import CoreLocation
import UIKit

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var showPermissionDeniedAlert = false
    private var manager = CLLocationManager()
    static var shared = LocationManager()
    
    private override init() {
           super.init()
           manager.delegate = self
           manager.desiredAccuracy = kCLLocationAccuracyBest
           checkLocationAuthorization()
       }
    
    
    func checkLocationAuthorization() {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined://The user choose allow or denny your app to get the location yet
                manager.requestWhenInUseAuthorization()
                
            case .restricted://The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
                print("Location restricted")
                
            case .denied://The user dennied your app to get location or disabled the services location or the phone is in airplane mode
                print("Location denied")
                showPermissionDeniedAlert = true
                
            case .authorizedAlways , .authorizedWhenInUse:
                print("Location authorizedAlways / inUse")
                manager.startUpdatingLocation()
                lastKnownLocation = manager.location?.coordinate
                            
            @unknown default:
                print("Location service disabled")
                
            }
        } else {
            // Fallback on earlier versions
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                        case .notDetermined:
                         manager.requestWhenInUseAuthorization()
                        case .authorizedAlways,.authorizedWhenInUse :
                        manager.startUpdatingLocation()
                        lastKnownLocation = manager.location?.coordinate
                        case .restricted, .denied:
                        print("Location restricted / denied")
                        showPermissionDeniedAlert = true
                        default:
                    lastKnownLocation = manager.location?.coordinate
                        }
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {//Trigged every time authorization status changes
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation() //To avoid location updates till user next request
        lastKnownLocation = locations.first?.coordinate
    }
    
    func openSettings() {
         if let url = URL(string: UIApplication.openSettingsURLString) {
             UIApplication.shared.open(url)
         }
     }
}
