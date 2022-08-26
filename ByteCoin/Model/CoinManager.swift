//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurreny(coinManager: CoinManager, ratio: CoinModel)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey = "596AB0A5-2D63-4436-9AAC-91B397561A09"
    var delegate: CoinManagerDelegate?
//    let coinArray = ["BTC", "ETH", "LTC", "BNB", "SXP"]
    let currencyArray = [["BTC", "ETH", "LTC", "BNB", "SXP"],["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]]

    
    func fetchRequest(coinName: String, currencyType: String) {
        let url = URL(string: "\(baseURL)\(coinName)/\(currencyType)?&apikey=\(apiKey)")!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
            }
            if let safeData = data {
                if let ratioData = parseJSON(with: safeData) {
                    delegate?.didUpdateCurreny(coinManager: self, ratio: ratioData)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(with data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let ratio = decodedData.rate
            let ratioData = CoinModel(rate: ratio)
            return ratioData
        }
        catch {
            print(error)
            return nil
        }
    }
}
