//
//  LocationSeachViewModel.swift
//  Uber
//
//  Created by admin on 02/02/24.
//

import Foundation
import MapKit

class LocationSeachViewModel: NSObject, ObservableObject {
    
    //MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate : CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment : String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation : CLLocationCoordinate2D?
    
    //MARK: - Lifecycle
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: - Helpers
    
    func selectLocation(_ location : MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: location) { response, error in
            if let error = error {
                print("DEBUG : Location Search Failed with error \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else {return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch : MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type : RideType) -> Double {
        guard let destCoordinate = selectedLocationCoordinate else { return 0.0}
        guard let userCoordinate = self.userLocation else { return 0.0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMetres = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMetres)
    }
    
}

//MARK: - MKLocalSearchCompleterDelegate

extension LocationSeachViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
