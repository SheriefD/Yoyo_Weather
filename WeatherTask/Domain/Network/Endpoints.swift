//
//  Endpoints.swift
//  WeatherTask
//
//  Created by Sherif on 22/11/2024.
//

import Foundation

enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case delete
}
protocol ApiConfig {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers : [String: Any] {get}
    var parameters: [String: String]? {get}
}
enum WeatherEndpoint:ApiConfig  {
    
    case current(lat:CGFloat?,lng:CGFloat?)
    case forecast(lat:CGFloat?,lng:CGFloat?)
  
    // MARK: - 1.Specify the HTTPMethod
    internal var method: HTTPMethod {
        switch self {
        default :
            return .get
        }
    }
    
    // MARK: - 2.set the Path (endpoint)
    internal var path: String {
        switch self {
        case .current:
            return "weather"
        case .forecast:
            return "forecast"
        }
    }
    
    internal var headers: [String : Any] {
        return [:]
    }
    
    // MARK: - Set Parameters
    internal var parameters: [String : String]? {
        switch self {
        case .current( let lat, let lng):
            return [Const.Api.latkey:"\(lat ?? Const.AppConstants.defaultLat)",Const.Api.lngkey:"\(lng ?? Const.AppConstants.defaultLng)",Const.Api.apikey:Const.Api.apikeyVal,Const.Api.unitsKey:Const.Api.unitsMetricVal]
        case .forecast(let lat, let lng):
            return [Const.Api.latkey:"\(lat ?? Const.AppConstants.defaultLat)",Const.Api.lngkey:"\(lng ?? Const.AppConstants.defaultLng)",Const.Api.apikey:Const.Api.apikeyVal,Const.Api.unitsKey:Const.Api.unitsMetricVal]
        }
    }
    // MARK: -  URLRequestConvertible (Build the URL)
    func asURLRequest() throws -> URLRequest {
        
        let url =  URL(string: Const.Api.baseURL)
        var urlRequest = URLRequest(url: url!.appendingPathComponent(path))
        var urlComps = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: true)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers as? [String:String]
        
        if self.parameters != nil {
                if self.method == .get , let params = self.parameters  {
                    var queryitems = [URLQueryItem]()
                    for prm in params {
                         let queryitem = URLQueryItem(name: prm.key, value: prm.value)
                        queryitems.append(queryitem)
                    }
                   
                    urlComps?.queryItems = queryitems
                }
            urlRequest.url = urlComps?.url!
            
                                }
       
        return urlRequest
    }
}
