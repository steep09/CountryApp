//
//  CountryDetailVC.swift
//  countryApp
//
//  Created by Stephenson Ang on 17/06/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

class CountryDetailVC: UIViewController {
    
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryAlpha2Code: UILabel!
    @IBOutlet weak var countryAlpha3Code: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!
    
    var flagImg: String!
    var nameLbl: String!
    var capitalLbl: String!
    var alpha2Lbl: String!
    var alpha3Lbl: String!
    var populationLbl: Int!
    
    func initData(flag: String, name: String, capital: String, alpha2: String, alpha3: String, population: Int) {
        self.flagImg = flag
        self.nameLbl = name
        self.capitalLbl = capital
        self.alpha2Lbl = alpha2
        self.alpha3Lbl = alpha3
        self.populationLbl = population
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = NSURL(string: flagImg) {
            if let data = NSData(contentsOf: url as URL) {
                countryFlag.image = UIImage(data: data as Data)
            }
        }
        countryName.text = nameLbl
        countryCapital.text = capitalLbl
        countryAlpha2Code.text = alpha2Lbl
        countryAlpha3Code.text = alpha3Lbl
        countryPopulation.text = "\(populationLbl ?? 0)"
    }

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
