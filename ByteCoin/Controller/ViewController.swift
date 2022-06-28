//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var BitCoinLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
       
    }
}
//MARK: - UIPicker settings
    extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
        // number of columns
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        // number of rows
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            coinManager.currencyArray.count
        }
        //row names(values) to pick up
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return coinManager.currencyArray[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let selectedCurrency = coinManager.currencyArray[row]
            coinManager.getCoinPrice(for: selectedCurrency)
        }
        
        
}
//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateCoinRate(_ CoinManager: CoinManager, coin: CoinModel) {
        
        DispatchQueue.main.async {
            self.BitCoinLabel.text = coin.rateValueString
            self.currencyLabel.text = coin.currencyValue
        }
    }
    
    func didFailWithError(_ CoinManager: CoinManager, error: Error) {
        print(error)
    }
    
}
