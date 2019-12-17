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
    
    //MARK: - IBOutlets

    @IBOutlet weak var incomeNameTextField: UITextField!
    @IBOutlet weak var incomeAmountTextField: UITextField!
    
    //MARK: - helper vars
    
    let incomeAmountTextFieldDelegate = DecimalTextFieldDelegate()
    // used to pass data using call back
    var addedIncome: (() -> ())?
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeAmountTextField.delegate = incomeAmountTextFieldDelegate
    }
    
    //MARK: - IBActions

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
}
