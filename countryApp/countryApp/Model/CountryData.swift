//
//  CountryData.swift
//  countryApp
//
//  Created by Stephenson Ang on 17/06/2019.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import Foundation


struct Country: Decodable {
    let flag: String
    let name: String
    let capital: String
    let alpha2Code: String
    let alpha3Code: String
    let population: Int
}
