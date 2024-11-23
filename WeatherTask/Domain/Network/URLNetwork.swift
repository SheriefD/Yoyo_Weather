//
//  URLNetwork.swift
//  WeatherTask
//
//  Created by Sherif on 21/11/2024.
//

import Foundation
protocol DataSourceProtocol{
    
}

class Network:DataSourceProtocol {
    static let shared = Network()
    private init() {}
    
    func request<T:Decodable>(req:URLRequest,completionHandler:@escaping ( Result<T, Error>?)->Void ){
        URLSession.shared.dataTask(with: req) { data, response, error in
            
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }
            
            let response = try! self.decodeJsonData(type: T.self, data: data)
//            print("jsonResponse \n :::: \(response)")
            DispatchQueue.main.async {
                completionHandler(response)
                }
        }.resume()
    }
    
    
     func decodeJsonData<T:Decodable>(type:T.Type,data:Data)->Result<T,Error> {
        do{
            let codableObject = try JSONDecoder().decode(type, from: data)
            return .success(codableObject)
            
        } catch  let JsonDecodingError {
            
            print(JsonDecodingError.localizedDescription)
            
            return .failure(JsonDecodingError)
        }
    }
}
