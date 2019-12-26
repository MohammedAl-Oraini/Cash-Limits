//
//  AddExpenseViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 08/11/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

class AddExpenseViewController: UIViewController {
    
    //MARK: - Core Data Persistent Container
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var currencySegmentedControl: UISegmentedControl!
    
    //MARK: - helper vars
    
    let amountTextFieldDelgate = DecimalTextFieldDelegate()
    // used to pass data using call back
    var addedExpense: (() -> ())?
    static var categoryName:String = ""
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.layer.masksToBounds = true
        
        amountTextField.delegate = amountTextFieldDelgate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        categoryLabel.text = AddExpenseViewController.categoryName
    }
    
    //MARK: - IBActions
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let amountString = amountTextField.text else { return }
        guard var amountDouble = Double(amountString) else { return }
        switch currencySegmentedControl.selectedSegmentIndex {
        case 0:
            break
        case 1:
            //convert to SAR from USD
            amountDouble = amountDouble * UserDefaults.standard.double(forKey: "usdRate")
        case 2:
            //convert to SAR from EUR
            amountDouble = amountDouble * UserDefaults.standard.double(forKey: "eurRate")
        default:
            break
        }
        let amountRounded = Double(round(100*amountDouble)/100)
        let amount = Decimal(amountRounded)
        Expense.addExpense(container: container, name: categoryLabel.text!, amount: amount)
        addedExpense?()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
