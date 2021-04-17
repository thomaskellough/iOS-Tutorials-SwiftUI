//
//  ContentView.swift
//  How-To-Use-Core-Location
//
//  Created by Thomas Kellough on 4/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var locationRetrieved = false
    @State private var addressRetrieved = false
    @State private var coordinates: String = ""
    @State private var address: String = ""
    private let coreLocationManager = CoreLocationManager()
    
    var body: some View {
        VStack(spacing: 10) {
            Button("Show location") {
                determineLocation()
            }
            
            if locationRetrieved {
                Text("Your coordinates are: \(coordinates)")
            }
            
            Button("Show address") {
                showAddress()
            }
            
            if addressRetrieved {
                Text("Your address is: \(address)")
            }
        }
    }
    
    func determineLocation() {
        guard let location = coreLocationManager.getCurrentLocation() else {
            locationRetrieved = false
            return
        }
        let latitude = location.latitude
        let longitude = location.longitude
        coordinates = "\(latitude), \(longitude)"
        locationRetrieved = true
    }
    
    func showAddress() {
        let floor = coreLocationManager.getFloor()
        print(floor)
        coreLocationManager.getAddress { returnedAddress in
            guard let unwrappedAddress = returnedAddress else {
                addressRetrieved = false
                return
            }

            address = unwrappedAddress
            addressRetrieved = true
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
