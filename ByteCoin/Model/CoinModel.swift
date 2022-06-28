//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Lyudmila Tokar on 3/23/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rateValue: Double
    let currencyValue: String
    
    var rateValueString: String {
        return String(format: "%.2f", rateValue)
    }
}
