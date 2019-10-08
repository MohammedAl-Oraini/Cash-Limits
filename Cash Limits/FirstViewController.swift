//
//  FirstViewController.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 08/10/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FirstViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    //@IBOutlet weak var customProgressView: CustomProgressView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        setupFlowLayout()
       // customProgressView.progressImage = UIImage.gradientImage(with: customProgressView.frame, colors: [UIColor.red.cgColor, UIColor.green.cgColor], locations: nil)
        // Do any additional setup after loading the view.
    }
    
    func setupFlowLayout() {
        
        let numberOfItemPerRow:CGFloat = 2
        let space:CGFloat = 10.0
        let width = (categoryCollectionView.frame.width - (numberOfItemPerRow - 1) * space) / numberOfItemPerRow
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

}

extension FirstViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.layer.cornerRadius = 15
        cell.customProgressView.progressImage = UIImage.gradientImage(with: cell.customProgressView.frame, colors: [UIColor.red.cgColor, UIColor.green.cgColor], locations: nil)
        
        if indexPath.row == 0 {
            cell.customProgressView.progress = 0.7
        }
        
        if indexPath.row == 2 {
            cell.customProgressView.progress = 0.2
        }
        
        let percentage = cell.customProgressView.progress
        
        cell.percentageLabel.text = "\(percentage * 100) %"
        
        return cell
    }
    
    
}

fileprivate extension UIImage {
    static func gradientImage(with bounds: CGRect,
                            colors: [CGColor],
                            locations: [NSNumber]?) -> UIImage? {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0,
                                        y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0,
                                        y: 0.5)

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}


