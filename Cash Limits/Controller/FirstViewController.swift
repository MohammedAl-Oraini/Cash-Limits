//
//  FirstViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 08/10/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class FirstViewController: UIViewController {
    
    //MARK: - Core Data Persistent Container
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var spentButton: UIButton!
    @IBOutlet weak var balanceButton: UIButton!
    
    var categoryCollection:[Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        setupFlowLayout()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCategories()
        print("added categories")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        categoryCollection.removeAll()
        print("remove all")
    }
    
    func setupView() {
        incomeButton.layer.cornerRadius = 15
        spentButton.layer.cornerRadius = 15
        balanceButton.layer.cornerRadius = 15
        //categoryCollectionView.bounds = CGRect(x: 0, y: 0, width: categoryCollectionView.bounds.width, height: categoryCollectionView.bounds.height)
    }
    
    func setupFlowLayout() {
        
        let numberOfItemPerRow:CGFloat = 2
        let space:CGFloat = 10.0
        let width = ((categoryCollectionView.frame.width - (numberOfItemPerRow - 1) * space) / numberOfItemPerRow) - 20
        let height = width
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
        //flowLayout.headerReferenceSize = CGSize(width: width, height: height)
        //flowLayout.footerReferenceSize = CGSize(width: width, height: height)
        //flowLayout.estimatedItemSize = CGSize(width: width, height: height)
        
        categoryCollectionView.reloadData()
        categoryCollectionView.layoutIfNeeded()
    }
    
    func loadCategories() {
        for category in Category.loadCategories(container:container) {
            categoryCollection.append(category)
        }
        categoryCollectionView.reloadData()
    }

}

extension FirstViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryCollection.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.categoryName.text = categoryCollection[indexPath.row].name
        cell.limitLabel.text = "Limit: \(categoryCollection[indexPath.row].limit ?? 0) SAR"
//        cell.layer.cornerRadius = 15
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.red.cgColor
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//        cell.layer.shadowRadius = 5
//        cell.layer.shadowOpacity = 1
//        cell.layer.masksToBounds = false
//        cell.addExpenseButton.layer.cornerRadius = 15
        //cell.customProgressView.progressImage = UIImage.gradientImage(with: cell.customProgressView.frame, colors: [UIColor.green.cgColor, UIColor.red.cgColor], locations: nil)
        //cell.customProgressView.trackImage = UIImage.gradientImage(with: cell.customProgressView.frame, colors: [UIColor.green.cgColor, UIColor.red.cgColor], locations: nil)
        
        if indexPath.row == 0 {
            cell.customProgressView.progress = 0.7
        }
        
        if indexPath.row == 2 {
            cell.customProgressView.progress = 0.2
        }
        
        if indexPath.row == 3 {
            cell.customProgressView.progress = 0.9
        }
        
        if cell.customProgressView.progress > 0.5 && cell.customProgressView.progress < 0.75 {
            cell.customProgressView.progressTintColor = .orange
        }
        if cell.customProgressView.progress >= 0.75 {
            cell.customProgressView.progressTintColor = .red
        }
        
        let percentage = cell.customProgressView.progress
        
        cell.percentageLabel.text = "\(percentage * 100) %"
        
        return cell
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
        }
    }
    
    
    
}

//fileprivate extension UIImage {
//    static func gradientImage(with bounds: CGRect,
//                            colors: [CGColor],
//                            locations: [NSNumber]?) -> UIImage? {
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.colors = colors
//        // This makes it horizontal
//        gradientLayer.startPoint = CGPoint(x: 0.0,
//                                        y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1.0,
//                                        y: 0.5)
//
//        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
//        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
//        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
//        UIGraphicsEndImageContext()
//        return image
//    }
//}


