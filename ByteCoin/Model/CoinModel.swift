//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Okan Özdemir on 26.08.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rate: Double
    var ratioRate: String {
        String(format: "%0.2f", self.rate)
    }
}
