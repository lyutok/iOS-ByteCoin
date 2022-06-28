//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate {
    func didUpdateCoinRate(_ CoinManager: CoinManager, coin: CoinModel)
  
    func didFailWithError(_ CoinManager: CoinManager, error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "3B9A9BF3-B499-453E-8C64-4559788CB538"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    //what a user choose from UI
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(self, error: error!)
                    return
                }
                // JSON parse
                if let safeData = data {
                    if let coin = parceJSON(safeData) {
                        delegate?.didUpdateCoinRate(self, coin: coin)
                    }
                }
            }
            
            //4.Start the Task
            task.resume()
        }
    }
    
    func parceJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let coinRate = decodedData.rate
            let currecy = decodedData.asset_id_quote
            
            let coin = CoinModel(rateValue: coinRate, currencyValue: currecy)
            return coin
            
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}
