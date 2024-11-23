//
//  ShimmerModifier.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation
import SwiftUI
        
class GlobalAlertManager: ObservableObject {
    static let shared = GlobalAlertManager()

    @Published var showAlert = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var primaryButtonText:String? = ""
    @Published var secondaryButtonText:String? = ""
    @Published var action:(()->Void)? = nil

    private init() {}

    func triggerAlert(title: String, message: String,primaryTxt:String? = "",secondaryTxt:String? = "",btnAction:(() -> Void)? = nil) {
        alertTitle = title
        alertMessage = message
        primaryButtonText = primaryTxt
        secondaryButtonText = secondaryTxt
        action = btnAction
        showAlert = true
//        GlobalAlertView(alertType: .withAction(action: <#T##() -> Void#>), content: <#T##_#>)
    }
    
}


struct GlobalAlertView<Content: View>: View {
    enum AlertTypes {
        case dimsissable
        case withAction(_ primaryTxt:String,_ secTxt:String ,action:()->Void)
    }
    var alertType:AlertTypes = .dimsissable
    @StateObject private var alertManager = GlobalAlertManager.shared
    let content: Content

    var body: some View {
        ZStack {
            content
                .alert(isPresented: $alertManager.showAlert) {
                    Alert(
                        title: Text(alertManager.alertTitle),
                        message: Text(alertManager.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            switch(alertType){
//            case .dimsissable:
            default:
                content
                    .alert(isPresented: $alertManager.showAlert) {
                        Alert(
                            title: Text(alertManager.alertTitle),
                            message: Text(alertManager.alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                
            }
        }
        
    }
}
struct GlobalAlertActionView<Content: View>: View {
    let action : () -> Void
    @StateObject private var alertManager = GlobalAlertManager.shared
    let content: Content

    var body: some View {
        ZStack {
            content
                .alert(isPresented: $alertManager.showAlert) {
                    Alert(
                        
                        title: Text(alertManager.alertTitle),
                        message: Text(alertManager.alertMessage),
                        primaryButton:.destructive(Text("Cancel")),
                        secondaryButton: .default(Text("Go to Settings"),action: {LocationManager.shared.openSettings()})
                    )
                    }
                }
        }
    }

func createLocationAlert() -> Alert {
    Alert(
            title: Text("Location Permission Denied"),
            message: Text("Please allow location access in Settings to use this feature."),
            primaryButton:.destructive(Text("Cancel")),
            secondaryButton: .default(Text("Go to Settings"),action: {LocationManager.shared.openSettings()})
            )
}
