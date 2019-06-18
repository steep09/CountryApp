//
//  ViewController.swift
//  countryApp
//
//  Created by Stephenson Ang on 17/06/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var resultsLbl: UILabel!
    
    var countries = [Country]()
    var filteredCountries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJson(urlToString: "https://restcountries.eu/rest/v2/all")
        
        countryTableView.delegate = self
        countryTableView.dataSource = self
        searchBar.delegate = self
        
        resultsLbl.isHidden = true
        
    }

    func parseJson(urlToString: String) {
        
        let url = URL(string: urlToString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    self.countries = try JSONDecoder().decode([Country].self, from: data!)
                    
                    self.filteredCountries = self.countries
                    
                    for sample in self.countries {
                        print(sample.flag)
                    }
                    
                    DispatchQueue.main.async {
                        //reload tableView data
                        self.countryTableView.reloadData()
                    }
                }
            } catch {
                print("Error parsing Json: \(error)")
            }
        }.resume()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
        
        let json = filteredCountries[indexPath.row]
        
        if let url = NSURL(string: json.flag) {
            if let data = NSData(contentsOf: url as URL) {
                cell.countryFlag.image = UIImage(data: data as Data)
            }
        }
        
        cell.countryName.text = "\(json.name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "CountryDetailVC") as! CountryDetailVC
        let json = filteredCountries[indexPath.row]
        detail.initData(flag: json.flag, name: json.name, capital: json.capital, alpha2: json.alpha2Code, alpha3: json.alpha3Code, population: json.population)
        present(detail, animated: false, completion: nil)
    }
    
}

extension MainVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchBar.text != "" else {
            filteredCountries = countries
            countryTableView.reloadData()
            return
        }
        filteredCountries = countries.filter({ country -> Bool in
            guard let text = searchBar.text else { return false }
            return country.name.contains(text) || country.alpha2Code.contains(text) || country.alpha3Code.contains(text)
        })
        countryTableView.reloadData()
    }
    
}
