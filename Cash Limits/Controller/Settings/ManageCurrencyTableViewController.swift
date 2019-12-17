//
//  ManageCurrencyTableViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 14/12/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit

class ManageCurrencyTableViewController: UITableViewController {

    @IBOutlet weak var updateBarButton: UIBarButtonItem!
    
    @IBOutlet weak var usdRateLabel: UILabel!
    @IBOutlet weak var eurRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usdRateLabel.text = "\(UserDefaults.standard.double(forKey: "usdRate"))"
        eurRateLabel.text = "\(UserDefaults.standard.double(forKey: "eurRate"))"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func updateButtonTapped(_ sender: UIBarButtonItem) {
        updateBarButton.isEnabled = false
        NetworkClient.getExchangeRate(completion: handleExchangeRate(exchangeRate:error:))
    }
    
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
                self.usdRateLabel.text = "\(UserDefaults.standard.double(forKey: "usdRate"))"
                self.eurRateLabel.text = "\(UserDefaults.standard.double(forKey: "eurRate"))"
            }
        } else {
            DispatchQueue.main.async {
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
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
