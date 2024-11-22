////
////  NetworkProtocol.swift
////  WeatherTask
////
////  Created by Sherif on 21/11/2024.
////
//
//import Foundation
//
//protocol HeaderData {}
//
//extension HeaderData {
//    var version:String {
//        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
//    }
//    var deviceName:String {
//        let device = UIDevice().name
//        let systemName = UIDevice().systemName
//        let operatingSys = UIDevice().systemVersion
//        
//        return systemName + "," + operatingSys + " , " + device
//    }
//    var deviceId:String { Helpers.toString(UIDevice.current.identifierForVendor?.uuidString)
//    }
//    var timeIntervalInMiliseconds:Int64 { Int64(Date().timeIntervalSince1970 * 1000) }
//    var timeIntervalInSeconds:Int64 { Int64(timeIntervalInMiliseconds / 1000)}
//    var deviceOs :String { return AppConstants.deviceOS}
//    var auth :String {
//        
//        if let profToken = UserDefaults.getFromDefaults(UserDefaults.Keys.profileToken, String.self) {
//            return "Bearer \(profToken)"
//        }
//           return  Validator.checkString(User.shared.token) ? "Bearer \(User.shared.token)" : ""
//        }
//}
//
//protocol APIConfiguration: URLRequestConvertible , HeaderData {
//    var method: HTTPMethod { get }
//    var path: String { get }
//    var parameters: Parameters? { get }
//}
//
//struct NetworkState {
//    var isInternetAvailable: Bool? {
//        return NetworkReachabilityManager()?.isReachable
//    }
//}
