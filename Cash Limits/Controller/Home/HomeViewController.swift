//
//  HomeViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 08/10/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class HomeViewController: UIViewController {
    
    //MARK: - Core Data Persistent Container
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    //MARK: - IBOutlets

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var spentButton: UIButton!
    @IBOutlet weak var balanceButton: UIButton!
    
    //MARK: - data source
    
    var categoryCollection:[Category] = []
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        setupFlowLayout()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCategories()
        loadBalance()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        categoryCollection.removeAll()
    }
    
    //MARK: - setup funcs
    
    func setupView() {
        incomeButton.layer.cornerRadius = 15
        spentButton.layer.cornerRadius = 15
        balanceButton.layer.cornerRadius = 15
    }
    
    func setupFlowLayout() {
        
        let numberOfItemPerRow:CGFloat = 2
        let space:CGFloat = 10.0
        let width = ((categoryCollectionView.frame.width - (numberOfItemPerRow - 1) * space) / numberOfItemPerRow) - 20
        let height = width
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
        
        categoryCollectionView.reloadData()
        categoryCollectionView.layoutIfNeeded()
    }
    
    //MARK: - load data funcs
    
    func loadCategories() {
        for category in Category.loadCategories(container:container) {
            categoryCollection.append(category)
        }
        categoryCollectionView.reloadData()
    }
    
    func loadBalance() {
        let totalExpenses = Expense.loadTotalExpenses(container: container)
        let totalIncome = Income.loadIncomes(container: container)
        let balance = totalIncome - totalExpenses
        incomeButton.setTitle("\(totalIncome) SAR", for: .normal)
        spentButton.setTitle("\(totalExpenses) SAR", for: .normal)
        balanceButton.setTitle("\(balance) SAR", for: .normal)
    }
    
    //MARK: - prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCategorySegue" {
            if let vc = segue.destination as? AddCategoryViewController {
                vc.container = container
                vc.addedCategory = {[weak self] category in
                    if let category = category {
                        self?.categoryCollection.append(category)
                        self?.categoryCollectionView.reloadData()
                    }
                }
            }
        } else if segue.identifier == "addExpenseSegueIdentifier" {
            if let vc = segue.destination as? AddExpenseViewController {
                vc.container = container
                vc.addedExpense = { [weak self]  in
                    self?.categoryCollectionView.reloadData()
                    self?.loadBalance()
                }
            }
        } else if segue.identifier == "addIncomeSegueIdentifier" {
            if let vc = segue.destination as? AddIncomeViewController {
                vc.container = container
                vc.addedIncome = { [weak self]  in
                    self?.loadBalance()
                }
            }
        }
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryCollection.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.customProgressView.progressTintColor = UIColor.clear
        let categoryName = categoryCollection[indexPath.row].name
        cell.categoryName.text = categoryName
        let limit = categoryCollection[indexPath.row].limit! as Decimal
        cell.limitLabel.text = "Limit: \(limit) SAR"
        let categoryExpenses = Expense.loadCategoryExpenses(container: container, name: categoryName!)
        cell.spentLabel.text = "Spent: \(categoryExpenses) SAR"
        cell.delegate = self
        let progressViewPresentage = categoryExpenses / limit
        if progressViewPresentage <= 1 {
            let progress = Float( truncating: progressViewPresentage as NSNumber)
            cell.customProgressView.progress = progress
        } else if progressViewPresentage > 1 {
            cell.customProgressView.progress = 1
        }
        
        if cell.customProgressView.progress > 0.5 && cell.customProgressView.progress < 0.75 {
            cell.customProgressView.progressTintColor = .systemOrange
        } else if cell.customProgressView.progress >= 0.75 {
            cell.customProgressView.progressTintColor = .systemRed
        }else {
           cell.customProgressView.progressTintColor = .systemGreen
        }
        
        let percentage = Int(cell.customProgressView.progress * 100)
        
        cell.percentageLabel.text = "\(percentage) %"
        
        return cell
    }
}

//MARK: - CellDelegate

extension HomeViewController : CategoryCollectionViewCellDelegate {
    func didTapAddExpence(name: String) {
        AddExpenseViewController.categoryName = name
        performSegue(withIdentifier: "addExpenseSegueIdentifier", sender: nil)
    }
}

