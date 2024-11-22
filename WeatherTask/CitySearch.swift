////
////  CitySearch.swift
////  WeatherTask
////
////  Created by Sherif on 21/11/2024.
////
//
//import Foundation
//
//
//import Foundation
//import Combine
//import MapKit
//
//final class LocalSearchService {
//    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
//    private let center: CLLocationCoordinate2D
//    private let radius: CLLocationDistance
//
//    init(in center: CLLocationCoordinate2D,
//         radius: CLLocationDistance = 350_000) {
//        self.center = center
//        self.radius = radius
//    }
//    
//    public func searchCities(searchText: String) {
//        request(resultType: .address, searchText: searchText)
//    }
//    
//    public func searchPointOfInterests(searchText: String) {
//        request(searchText: searchText)
//    }
//    
//    private func request(resultType: MKLocalSearch.ResultType = .pointOfInterest,
//                         searchText: String) {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = searchText
//        request.pointOfInterestFilter = .includingAll
//        request.resultTypes = resultType
//        request.region = MKCoordinateRegion(center: center,
//                                            latitudinalMeters: radius,
//                                            longitudinalMeters: radius)
//        let search = MKLocalSearch(request: request)
//
//        search.start { [weak self](response, _) in
//            guard let response = response else {
//                return
//            }
//
//            self?.localSearchPublisher.send(response.mapItems)
//        }
//    }
//}
//
//
//
//
//import MapKit
//import Combine
//
//final class ContentViewModel: ObservableObject {
//    private var cancellable: AnyCancellable?
//
//    @Published var cityText = "" {
//        didSet {
//            searchForCity(text: cityText)
//        }
//    }
//    
//    @Published var poiText = "" {
//        didSet {
//            searchForPOI(text: poiText)
//        }
//    }
//    
//    @Published var viewData = [LocalSearchViewData]()
//
//    var service: LocalSearchService
//    
//    init() {
////        New York
//        let center = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
//        service = LocalSearchService(in: center)
//        
//        cancellable = service.localSearchPublisher.sink { mapItems in
//            self.viewData = mapItems.map({ LocalSearchViewData(mapItem: $0) })
//        }
//    }
//    
//    private func searchForCity(text: String) {
//        service.searchCities(searchText: text)
//    }
//    
//    private func searchForPOI(text: String) {
//        service.searchPointOfInterests(searchText: text)
//    }
//}
//
//
//
//
//
//
//import SwiftUI
//
//struct ContentView: View {
//    @StateObject private var viewModel = ContentViewModel()
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            TextField("Enter City", text: $viewModel.cityText)
//            Divider()
//            TextField("Enter Point of interest name", text: $viewModel.poiText)
//            Divider()
//            Text("Results")
//                .font(.title)
//            List(viewModel.viewData) { item in
//                VStack(alignment: .leading) {
//                    Text(item.title)
//                    Text(item.subtitle)
//                        .foregroundColor(.secondary)
//                }
//            }
//        }
//        .padding(.horizontal)
//        .padding(.top)
//        .ignoresSafeArea(edges: .bottom)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
//////core location vs mapkit
//
//import CoreLocation
//
//func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
//    CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
//}
//Usage:
//
//let address = "Rio de Janeiro, Brazil"
//
//getCoordinateFrom(address: address) { coordinate, error in
//    guard let coordinate = coordinate, error == nil else { return }
//    // don't forget to update the UI from the main thread
//    DispatchQueue.main.async {
//        print(address, "Location:", coordinate) // Rio de Janeiro, Brazil Location: CLLocationCoordinate2D(latitude: -22.9108638, longitude: -43.2045436)
//    }
//
//}
