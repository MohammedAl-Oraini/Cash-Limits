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
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    
    let amountTextFieldDelgate = DecimalTextFieldDelegate()
    
     var addedExpense: (() -> ())?
    
    static var categoryName:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.layer.cornerRadius = 15
        categoryLabel.layer.masksToBounds = true
        
        amountTextField.delegate = amountTextFieldDelgate

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryLabel.text = AddExpenseViewController.categoryName
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let amountString = amountTextField.text else { return }
        guard let amountDouble = Double(amountString) else { return }
        let amount = Decimal(amountDouble)
        Expense.addExpense(container: container, name: categoryLabel.text!, amount: amount)
        addedExpense?()
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
