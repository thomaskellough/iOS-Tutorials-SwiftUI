//
//  Home.swift
//  How-To-Use-Dynamic-Coding-Keys
//
//  Created by Thomas Kellough on 5/29/23.
//

struct DynamicKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}

enum DynamicKeyError: Error {
    case dynamicKeyNotFound
    case valueNotFound
}

// MARK:  Option 3

struct Home: Codable {
    var id: Int = 0
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
    var price: Int = 0
    var bedrooms: Int = 0
    var bathrooms: Int = 0
    var description: String = ""

    private var amenities: [String] = []
    
    private func decodeRequiredWithKey<T: Decodable>(_ type: T.Type, key: String, container: KeyedDecodingContainer<DynamicKey>) throws -> T {
        guard let dynamicKey = DynamicKey(stringValue: key) else {
            throw DynamicKeyError.dynamicKeyNotFound
        }
        
        do {
            return try container.decode(type, forKey: dynamicKey)
        } catch DecodingError.keyNotFound {
            throw DecodingError.keyNotFound(dynamicKey, DecodingError.Context(codingPath: [], debugDescription: "Required property '\(key)' is missing"))
        } catch {
            throw DynamicKeyError.valueNotFound
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        
        self.id = try decodeRequiredWithKey(Int.self, key: "id", container: container)
        self.address = try decodeRequiredWithKey(String.self, key: "address", container: container)
        self.city = try decodeRequiredWithKey(String.self, key: "city", container: container)
        self.state = try decodeRequiredWithKey(String.self, key: "state", container: container)
        self.zip = try decodeRequiredWithKey(String.self, key: "zip", container: container)
        self.price = try decodeRequiredWithKey(Int.self, key: "price", container: container)
        self.bedrooms = try decodeRequiredWithKey(Int.self, key: "bedrooms", container: container)
        self.bathrooms = try decodeRequiredWithKey(Int.self, key: "bathrooms", container: container)
        self.description = try decodeRequiredWithKey(String.self, key: "description", container: container)
        
        var amenitiesArr: [String] = []
        for key in container.allKeys {
            if key.stringValue.hasPrefix("amenity"), let amenity = try container.decodeIfPresent(String.self, forKey: key) {
                if amenity.isEmpty { continue }
                amenitiesArr.append(amenity)
            }
        }
        self.amenities = amenitiesArr
    }

    func getAmenities() -> [String] {
        return amenities
    }
}

// MARK:  Option 2

//struct Home: Codable {
//    let id: Int
//    let address: String
//    let city: String
//    let state: String
//    let zip: String
//    let price: Int
//    let bedrooms: Int
//    let bathrooms: Int
//    let description: String
//
//    private var amenities: [String] = []
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: DynamicKey.self)
//
//        if let idKey = DynamicKey(stringValue: "id"), let id = try container.decodeIfPresent(Int.self, forKey: idKey) {
//            self.id = id
//        } else {
//            throw DecodingError.keyNotFound(DynamicKey(stringValue: "id")!, DecodingError.Context(codingPath: [], debugDescription: "Required property 'id' is missing"))
//        }
//
//        if let addressKey = DynamicKey(stringValue: "address"), let address = try container.decodeIfPresent(String.self, forKey: addressKey) {
//            self.address = address
//        } else {
//            throw DecodingError.keyNotFound(DynamicKey(stringValue: "address")!, DecodingError.Context(codingPath: [], debugDescription: "Required property 'address' is missing"))
//        }
//
//        if let cityKey = DynamicKey(stringValue: "city"), let city = try container.decodeIfPresent(String.self, forKey: cityKey) {
//            self.city = city
//        } else {
//            throw DecodingError.keyNotFound(DynamicKey(stringValue: "city")!, DecodingError.Context(codingPath: [], debugDescription: "Required property 'city' is missing"))
//        }
//
//        if let stateKey = DynamicKey(stringValue: "state"), let state = try container.decodeIfPresent(String.self, forKey: stateKey) {
//            self.state = state
//        } else {
//            throw DecodingError.keyNotFound(DynamicKey(stringValue: "state")!, DecodingError.Context(codingPath: [], debugDescription: "Required property 'state' is missing"))
//        }
//
//        if let zipKey = DynamicKey(stringValue: "zip"), let zip = try container.decodeIfPresent(String.self, forKey: zipKey) {
//            self.zip = zip
//        } else {
//            throw DecodingError.keyNotFound(DynamicKey(stringValue: "zip")!, DecodingError.Context(codingPath: [], debugDescription: "Required property 'zip' is missing"))
//        }
//
//        if let priceKey = DynamicKey(stringValue: "price"), let price = try container.decodeIfPresent(Int.self, forKey: priceKey) {
//            self.price = price
//        } else {
//            throw DecodingError.keyNotFound(DynamicKey(stringValue: "price")!, DecodingError.Context(codingPath: [], debugDescription: "Required property 'price' is missing"))
//        }
//
//        if let bedroomsKey = DynamicKey(stringValue: "bedrooms"), let bedrooms = try container.decodeIfPresent(Int.self, forKey: bedroomsKey) {
//            self.bedrooms = bedrooms
//        } else {
//            throw DecodingError.keyNotFound(DynamicKey(stringValue: "bedrooms")!, DecodingError.Context(codingPath: [], debugDescription: "Required property 'bedrooms' is missing"))
//        }
//
//        if let bathroomsKey = DynamicKey(stringValue: "bathrooms"), let bathrooms = try container.decodeIfPresent(Int.self, forKey: bathroomsKey) {
//            self.bathrooms = bathrooms
//        } else {
//            throw DecodingError.keyNotFound(DynamicKey(stringValue: "bathrooms")!, DecodingError.Context(codingPath: [], debugDescription: "Required property 'bathrooms' is missing"))
//        }
//
//        if let descriptionKey = DynamicKey(stringValue: "description"), let description = try container.decodeIfPresent(String.self, forKey: descriptionKey) {
//            self.description = description
//        } else {
//            throw DecodingError.keyNotFound(DynamicKey(stringValue: "bathrooms")!, DecodingError.Context(codingPath: [], debugDescription: "Required property 'bathrooms' is missing"))
//        }
//
//        var amenitiesArr: [String] = []
//        for key in container.allKeys {
//            if key.stringValue.hasPrefix("amenity"), let amenity = try container.decodeIfPresent(String.self, forKey: key) {
//                if amenity.isEmpty { break }
//                amenitiesArr.append(amenity)
//            }
//        }
//        self.amenities = amenitiesArr
//    }
//
//    func getAmenities() -> [String] {
//        return amenities
//    }
//}

// MARK:  Option 1
//struct Home: Codable {
//    let id: Int
//    let address: String
//    let city: String
//    let state: String
//    let zip: String
//    let price: Int
//    let bedrooms: Int
//    let bathrooms: Int
//    let description: String
//
//    private var amenities: [String] = []
//
//    private let amenity1: String = ""
//    private let amenity2: String = ""
//    private let amenity3: String = ""
//    private let amenity4: String = ""
//    private let amenity5: String = ""
//    private let amenity6: String = ""
//    private let amenity7: String = ""
//    private let amenity8: String = ""
//    private let amenity9: String = ""
//    private let amenity10: String = ""
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.address = try container.decode(String.self, forKey: .address)
//        self.city = try container.decode(String.self, forKey: .city)
//        self.state = try container.decode(String.self, forKey: .state)
//        self.zip = try container.decode(String.self, forKey: .zip)
//        self.price = try container.decode(Int.self, forKey: .price)
//        self.bedrooms = try container.decode(Int.self, forKey: .bedrooms)
//        self.bathrooms = try container.decode(Int.self, forKey: .bathrooms)
//        self.description = try container.decode(String.self, forKey: .description)
//
//        // Initialize amenities using a loop
//        var amenitiesArr: [String] = []
//        for key in container.allKeys {
//            if key.stringValue.hasPrefix("amenity"), let amenity = try container.decodeIfPresent(String.self, forKey: key) {
//                amenitiesArr.append(amenity)
//            }
//        }
//        self.amenities = amenitiesArr
//    }
//
//
//    func getAmenities() -> [String] {
//        return amenities.filter { !$0.isEmpty }
//    }
//}
