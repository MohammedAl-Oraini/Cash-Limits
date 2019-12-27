//
//  ResetViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 27/12/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

class ResetViewController: UIViewController {
    
    //MARK: - Core Data Persistent Container
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    //MARK: - IBActions


    
    @IBAction func resetIncomeTapped(_ sender: UIButton) {
        Income.resetIncome(container: container)
    }
    
    @IBAction func resetCategoryTapped(_ sender: UIButton) {
        Category.resetCategory(container: container)
    }
    
    @IBAction func resetExpenseTapped(_ sender: UIButton) {
        Expense.resetExpense(container: container)
    }

}
