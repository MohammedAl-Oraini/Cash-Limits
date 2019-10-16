//
//  AddCategoryViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 12/10/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

class AddCategoryViewController: UIViewController {
    
    //MARK: - Core Data Persistent Container
       
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var categoryLimitTextField: UITextField!
    
    var addedCategory: ((_ category:Category?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = categoryNameTextField.text else { return }
        guard let limitString = categoryLimitTextField.text else { return }
        guard let limitDouble = Double(limitString) else { return }
        let limit = Decimal(limitDouble)
        addedCategory?(Category.saveCategory(name: name, limit: limit, container: container))
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
