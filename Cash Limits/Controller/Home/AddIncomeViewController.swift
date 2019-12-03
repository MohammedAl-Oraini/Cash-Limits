//
//  AddIncomeViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 24/11/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

class AddIncomeViewController: UIViewController {
    
    //MARK: - Core Data Persistent Container
        
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    @IBOutlet weak var incomeNameTextField: UITextField!
    @IBOutlet weak var incomeAmountTextField: UITextField!
    
    let incomeAmountTextFieldDelegate = DecimalTextFieldDelegate()
    
    var addedIncome: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeAmountTextField.delegate = incomeAmountTextFieldDelegate

        // Do any additional setup after loading the view.
    }
    

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = incomeNameTextField.text else { return }
        guard let amountString = incomeAmountTextField.text else { return }
        guard let amountDouble = Double(amountString) else { return }
        let amount = Decimal(amountDouble)
        Income.saveIncome(name: name, amount: amount, container: container)
        addedIncome?()
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
