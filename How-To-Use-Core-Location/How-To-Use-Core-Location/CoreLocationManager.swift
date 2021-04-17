//
//  CoreLocationManager.swift
//  How-To-Use-Core-Location
//
//  Created by Thomas Kellough on 4/2/21.
//

import CoreLocation

class CoreLocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    func determineCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func getFloor() -> Date {
        determineCurrentLocation()
        let blah = CLVisit()
        return blah.departureDate
    }
    
    func getCurrentLocation() -> CLLocationCoordinate2D? {
        determineCurrentLocation()
        
        return locationManager.location?.coordinate
    }
    
    func getAddress(completion: @escaping (String?) -> Void) {
        guard let coordinates = getCurrentLocation() else { return }
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                print("Error: \(error)")
                completion(nil)
            }
            
            if placemarks != nil {
                guard let first = placemarks?.first else {
                    completion(nil)
                    return
                }
                
                guard let street = first.name else { return }
                guard let city = first.locality else { return }
                guard let state = first.administrativeArea else { return }
                
                completion("\(street) \(city), \(state)")
            }
        }
    }
}
