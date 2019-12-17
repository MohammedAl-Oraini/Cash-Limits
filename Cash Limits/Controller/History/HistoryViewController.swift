//
//  HistoryViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 08/10/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    //MARK: - Core Data Persistent Container
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var orderSegmentedControl: UISegmentedControl!
    
    //MARK: - data source
    
    var expensesCollection:[Expense] = []
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadExpenses()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        expensesCollection.removeAll()
    }
    
    //MARK: - load data funcs
    
    func loadSortedByDateExpenses() {
        expensesCollection.removeAll()
        for expense in Expense.loadExpenses(container:container) {
            expensesCollection.append(expense)
        }
        historyTableView.reloadData()
    }
    
    func loadSortedByAmountExpenses() {
        expensesCollection.removeAll()
        for expense in Expense.loadExpensesWithAmountSort(container: container) {
            expensesCollection.append(expense)
        }
        historyTableView.reloadData()
    }
    
    func loadExpenses() {
        switch orderSegmentedControl.selectedSegmentIndex {
        case 0:
            loadSortedByDateExpenses()
        case 1:
            loadSortedByAmountExpenses()
        default:
            break
        }
    }
    
    //MARK: - IBAction
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        loadExpenses()
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource 

extension HistoryViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expensesCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell1", for: indexPath) as! HistoryTableViewCell
        cell.expenseAmount.text = "\(expensesCollection[indexPath.row].amount!) SAR"
        cell.categoryLabel.text = "\(expensesCollection[indexPath.row].expenceCategory!.name!)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: expensesCollection[indexPath.row].date!)
        cell.dateLabel.text = "\(date)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: 100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
