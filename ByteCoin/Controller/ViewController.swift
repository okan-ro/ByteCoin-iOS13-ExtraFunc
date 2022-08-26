//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var chainImage: UIImageView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }


}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray[component].count
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
        return coinManager.currencyArray[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyText = coinManager.currencyArray
        let coinRow = pickerView.selectedRow(inComponent: 0)
        let currencyRow = pickerView.selectedRow(inComponent: 1)
        
        currencyLabel.text = currencyText[1][currencyRow]
        chainImage.image = UIImage(named: currencyText[0][coinRow])

        coinManager.fetchRequest(coinName: currencyText[0][coinRow], currencyType: currencyText[1][currencyRow])
       
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didUpdateCurreny(coinManager: CoinManager, ratio: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = ratio.ratioRate
            print(ratio.ratioRate)
        }
    }
}
