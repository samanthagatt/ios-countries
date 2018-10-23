//
//  CountriesTableViewController.swift
//  Countries Search
//
//  Created by Samantha Gatt on 10/23/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    
    // MARK: - Properties
    
    let countryController = CountryController.shared
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        countryController.fetch(countries: searchText) { error in
            if let error = error {
                NSLog("Error fetching countries: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryController.countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = countryController.countries[indexPath.row]
        cell.textLabel?.text = country.name
        return cell
    }
    
    
}

