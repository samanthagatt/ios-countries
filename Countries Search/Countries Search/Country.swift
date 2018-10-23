//
//  Country.swift
//  Countries Search
//
//  Created by Samantha Gatt on 10/23/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

struct Country: Decodable {
    
    // MARK: - Properties
    
    var name: String
    var region: String
    var capital: String
    var population: Int
    var currencies: String
    var languages: String
    var flag: UIImage
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case name
        case region
        case capital
        case population
        case currencies
        case languages
        case flag = "alpha3Code"
        
        enum CurrencyAndLanguageCodingKeys: String, CodingKey {
            case name
        }
    }
    
    
    // MARK: - Decodable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let region = try container.decode(String.self, forKey: .region)
        let capital = try container.decode(String.self, forKey: .capital)
        let population = try container.decode(Int.self, forKey: .population)
        var currenciesContainer = try container.nestedUnkeyedContainer(forKey: .currencies)
        var languagesContainer = try container.nestedUnkeyedContainer(forKey: .languages)
        let abrv = try container.decode(String.self, forKey: .flag)
        let flag = UIImage(named: abrv.lowercased()) ?? UIImage(named: "usa")!
        
        var currencies = ""
        while !currenciesContainer.isAtEnd {
            let currency = try currenciesContainer.nestedContainer(keyedBy: CodingKeys.CurrencyAndLanguageCodingKeys.self)
           let name = try currency.decode(String.self, forKey: .name)
            currencies += "\(name), "
        }
        let _ = currencies.popLast()
        let _ = currencies.popLast()

        var languages = ""
        while !languagesContainer.isAtEnd {
            let languageContainer = try languagesContainer.nestedContainer(keyedBy: CodingKeys.CurrencyAndLanguageCodingKeys.self)
            let name = try languageContainer.decode(String.self, forKey: .name)
            languages += "\(name), "
        }
        let _ = languages.popLast()
        let _ = languages.popLast()
        
        
        self.name = name
        self.region = region
        self.capital = capital
        self.population = population
        self.currencies = currencies
        self.languages = languages
        self.flag = flag
    }
}
