//
//  ManageCurrencyTableViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 14/12/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit

class ManageCurrencyTableViewController: UITableViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var updateBarButton: UIBarButtonItem!
    @IBOutlet weak var usdRateLabel: UILabel!
    @IBOutlet weak var eurRateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usdRateLabel.text = "\(UserDefaults.standard.double(forKey: "usdRate"))"
        eurRateLabel.text = "\(UserDefaults.standard.double(forKey: "eurRate"))"

    }
    
    //MARK: - IBAction

    @IBAction func updateButtonTapped(_ sender: UIBarButtonItem) {
        updateBarButton.isEnabled = false
        activityIndicator.startAnimating()
        NetworkClient.getExchangeRate(completion: handleExchangeRate(exchangeRate:error:))
    }
    
    //MARK: - handle func
    
    func handleExchangeRate(exchangeRate: ExchangeRate?,error:Error?){
        if let exchangeRate = exchangeRate {
            print("USD Ex = \(exchangeRate.rates.USD)")
            let eurRate = exchangeRate.rates.SAR
            let euroRateRounded = Double(round(100*eurRate)/100)
            print("EUR = \(euroRateRounded)")
            UserDefaults.standard.set(euroRateRounded, forKey: "eurRate")
            let usdRate = exchangeRate.rates.SAR / exchangeRate.rates.USD
            let usdRateRounded = Double(round(100*usdRate)/100)
            UserDefaults.standard.set(usdRateRounded, forKey: "usdRate")
            DispatchQueue.main.async {
                self.updateBarButton.isEnabled = true
                self.activityIndicator.stopAnimating()
                self.usdRateLabel.text = "\(UserDefaults.standard.double(forKey: "usdRate"))"
                self.eurRateLabel.text = "\(UserDefaults.standard.double(forKey: "eurRate"))"
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.showMessageFailure(message: "Try again later !")
            }
        }
    }
    
    //MARK: - error handling method
    
    func showMessageFailure(message: String) {
        let alertVC = UIAlertController(title: "Error Updating", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

}
