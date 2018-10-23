//
//  CountryController.swift
//  Countries Search
//
//  Created by Samantha Gatt on 10/23/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class CountryController {
    static let shared = CountryController()
    
    var countries: [Country] = []
    
    func fetch(countries searchString: String, completion: @escaping (Error?) -> Void = { _ in }) {
        let baseURL = URL(string: "https://restcountries.eu/rest/v2/name")!
        let url = baseURL.appendingPathComponent(searchString)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching countries: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error, no country data returned from fetch")
                completion(NSError())
                return
            }
            
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                self.countries = countries
                completion(nil)
            } catch {
                NSLog("")
                completion(error)
                return
            }
        }.resume()
    }
}
