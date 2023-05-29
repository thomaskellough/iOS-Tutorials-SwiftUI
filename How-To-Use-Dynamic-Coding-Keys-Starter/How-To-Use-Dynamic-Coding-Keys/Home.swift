//
//  Home.swift
//  How-To-Use-Dynamic-Coding-Keys
//
//  Created by Thomas Kellough on 5/29/23.
//

struct Home: Codable {
    let id: Int
    let address: String
    let city: String
    let state: String
    let zip: String
    let price: Int
    let bedrooms: Int
    let bathrooms: Int
    let description: String
    
    private let amenity1: String
    private let amenity2: String
    private let amenity3: String
    private let amenity4: String
    private let amenity5: String
    private let amenity6: String
    private let amenity7: String
    private let amenity8: String
    private let amenity9: String
    private let amenity10: String
    
    init(id: Int, address: String, city: String, state: String, zip: String, price: Int, bedrooms: Int, bathrooms: Int, description: String, photos: [String], amenity1: String, amenity2: String, amenity3: String, amenity4: String, amenity5: String, amenity6: String, amenity7: String, amenity8: String, amenity9: String, amenity10: String) {
        self.id = id
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.price = price
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.description = description
        self.amenity1 = amenity1
        self.amenity2 = amenity2
        self.amenity3 = amenity3
        self.amenity4 = amenity4
        self.amenity5 = amenity5
        self.amenity6 = amenity6
        self.amenity7 = amenity7
        self.amenity8 = amenity8
        self.amenity9 = amenity9
        self.amenity10 = amenity10
    }
    
    func getAmenities() -> [String] {
        return [amenity1, amenity2, amenity3, amenity4, amenity5, amenity6, amenity7, amenity8, amenity9, amenity10].filter { !$0.isEmpty }
    }
}
