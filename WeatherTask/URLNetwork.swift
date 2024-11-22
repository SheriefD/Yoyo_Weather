//
//  URLNetwork.swift
//  WeatherTask
//
//  Created by Sherif on 21/11/2024.
//

import Foundation

class NetworkCall : ObservableObject{
    @Published var weatherResponse :CurrentWeatherResponse? = nil
    @Published var forecastResponse :ForecastResponse? = nil
    
    var baseURL = "api.openweathermap.org/data/2.5/"
    
    var lat = Const.AppConstants.defaultLat
    var lng = Const.AppConstants.defaultLng
    
    func loadWeatherData(completion:@escaping (CurrentWeatherResponse?) -> ()) {

        guard let urlRequest = try? WeatherEndpoint.current(lat: lat, lng: lng).asURLRequest() else {
            completion(nil)
            return
        }
    
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            print("jsonResponse \n :::: \(response)")
            let response = try! JSONDecoder().decode(CurrentWeatherResponse.self, from: data!)
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                    completion(response)
                }
            }
        }.resume()
    }
    
    func loadForecastData(completion:@escaping (ForecastResponse?) -> ()) {

        guard let urlRequest = try? WeatherEndpoint.forecast(lat: lat, lng: lng).asURLRequest() else {
            completion(nil)
            return
        }
    
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            print("jsonResponse \n :::: \(response)")
            let response = try! JSONDecoder().decode(ForecastResponse.self, from: data!)
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                    print("xxxx:",response.list.count)
                    completion(response)
                }
            }
        }.resume()
    }
}


//
//func callWebService<T:Decodable> (_ url :APIConfiguration, _ isCache: Bool, _ forceCache: Bool = false, _ completionHandler: @escaping  ( Result<T, WebserviceError>? )->Void) where T : Decodable {
//
//    guard let urlRequest = try? url.asURLRequest() else {
//        completionHandler(nil)
//        return
//    }

//
//protocol NetworkSessionProtocol:HeaderData {
//    var crypto:Crypto {get set}
//    func request<T:Decodable>(urlRequest:URLRequest,completionHandler:@escaping ( Result<T, WebserviceError>?)->Void )
//}
