//
//  HomeListView.swift
//  How-To-Use-Dynamic-Coding-Keys
//
//  Created by Thomas Kellough on 5/29/23.
//

import SwiftUI

struct HomeListView: View {
    @StateObject private var networkManager = NetworkManager()
    @State private var homes: [Home] = []
    
    var body: some View {
        NavigationView {
            List(homes, id: \.id) { home in
                VStack(alignment: .leading, spacing: 8) {
                    Text(home.address)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Price: $\(home.price)")
                        .foregroundColor(.green)
                        .font(.headline)
                    
                    Text("\(home.bedrooms) Bedrooms")
                        .font(.subheadline)
                    
                    Text("\(home.bathrooms) Bathrooms")
                        .font(.subheadline)
                    
                    Text(home.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    if !home.getAmenities().isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Amenities:")
                                .font(.headline)
                            
                            ForEach(home.getAmenities(), id: \.self) { amenity in
                                Text("- \(amenity)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Homes for Sale")
        }
        .onAppear {
            networkManager.getHomesData { homes in
                if let homes = homes {
                    self.homes = homes
                }
            }
        }
    }
}
