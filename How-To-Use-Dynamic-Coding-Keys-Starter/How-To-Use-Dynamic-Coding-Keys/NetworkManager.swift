//
//  NetworkManager.swift
//  How-To-Use-Dynamic-Coding-Keys
//
//  Created by Thomas Kellough on 5/29/23.
//

import Foundation

class NetworkManager: ObservableObject {
    func getHomesData(completion: @escaping ([Home]?) -> Void) {
        guard let jsonURL = Bundle.main.url(forResource: "homesData", withExtension: "json") else {
            completion(nil)
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            let homes = try decoder.decode([Home].self, from: jsonData)
            completion(homes)
        } catch {
            print("Error decoding JSON: \(error)")
            completion(nil)
        }
    }
}

