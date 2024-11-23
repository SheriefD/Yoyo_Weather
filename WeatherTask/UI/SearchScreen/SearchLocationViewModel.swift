//
//  SearchLocationViewModel.swift
//  WeatherTask
//
//  Created by Sherif on 23/11/2024.
//

import Foundation
import CoreLocation

class SearchLocationViewModel:ObservableObject {
    
    private let geocoder = CLGeocoder()
    @Published var searchResults:[CLPlacemark] = []
    @Published var viewState:ViewState = .idle
    private var searchWorkItem: DispatchWorkItem?


    func formatAddress(add:CLPlacemark)->String {
        var address:String = ""
        
        if let name = add.name {
            address.append(name)
        }
        if let city = add.subAdministrativeArea {
            address.append(",\(city)")
        }
//        if let state = add.administrativeArea {
//            address.append(",\(state)")
//        }
        if let country = add.country {
            address.append(",\(country)")
        }
        return address
    }
    
    func getAddressFrom(address: String, completion: @escaping(_ coordinate: [CLPlacemark]?, _ error: Error?) -> () ) {
        viewState = .loading
        geocoder.cancelGeocode()
        geocoder.geocodeAddressString(address){ placemarks, error in
            //            completion($0?.first?.location?.coordinate, $1) }
            self.viewState = .success(nil)
            if let error = error {
                completion(nil, error)
            } else {
                if let placemarks = placemarks {
                    completion(placemarks, nil)
                }
            }
        }
    }
    
    func debounceSearch(query: String) {
        searchWorkItem?.cancel()
        let workitem = DispatchWorkItem{
            self.getAddressFrom(address: query, completion: {res,_ in
                if let results = res {
                    self.searchResults = results
                } else {
                    self.searchResults = []
                }
        })
                           }
        searchWorkItem = workitem
               // Execute the work item after a delay (e.g., 0.5 seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:workitem)
           }
    
}
