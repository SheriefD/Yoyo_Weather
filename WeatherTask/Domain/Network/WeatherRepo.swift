//
//  CurrentWeatherRepo.swift
//  WeatherTask
//
//  Created by Sherif on 23/11/2024.
//

import Foundation
protocol WeatherRepoProtocol{
    func loadForecastData(lat:CGFloat?,lng: CGFloat?,completion:@escaping (ForecastResponse?) -> ())
    func loadWeatherData(lat:CGFloat?,lng: CGFloat?,completion:@escaping (CurrentWeatherResponse?) -> ())
}

class WeatherRepo : ObservableObject,WeatherRepoProtocol{
    
    private var network:DataSourceProtocol?
        
    init(dataSource:DataSourceProtocol?) {
        if let source = dataSource {
            network = source
        }
    }
    
    func loadWeatherData(lat:CGFloat? = Const.AppConstants.defaultLat ,lng:CGFloat? = Const.AppConstants.defaultLng , completion:@escaping (CurrentWeatherResponse?) -> ()) {

        guard let urlRequest = try? WeatherEndpoint.current(lat: lat, lng: lng).asURLRequest() else {
            completion(nil)
            return
        }
    
        Network.shared.request(req: urlRequest, completionHandler: {( result:Result<CurrentWeatherResponse,Error>?) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let res):
                    completion(res)
                case .failure(_):
                    completion(nil)
                default:
                    completion(nil)
                }
        }
        })
    }
    
    func loadForecastData(lat:CGFloat? = Const.AppConstants.defaultLat ,lng:CGFloat? = Const.AppConstants.defaultLng ,completion:@escaping (ForecastResponse?) -> ()) {

        guard let urlRequest = try? WeatherEndpoint.forecast(lat: lat, lng: lng).asURLRequest() else {
            completion(nil)
            return
        }
    
        
        Network.shared.request(req: urlRequest, completionHandler: {( result:Result<ForecastResponse,Error>?) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let res):
                    completion(res)
                case .failure(let error):
                    completion(nil)
                default:
                    completion(nil)
                }
        }
        })
    }
}
