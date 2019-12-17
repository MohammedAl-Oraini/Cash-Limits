//
//  CategoryCollectionViewCell.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 08/10/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var customProgressView: CustomProgressView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var addExpenseButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    
    //MARK: - cell delegate
    
    weak var delegate: CategoryCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
               lpgr.minimumPressDuration = 0.08
               lpgr.delaysTouchesBegan = false
               cellView.addGestureRecognizer(lpgr)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - IBAction
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print("button Tapped")
        delegate?.didTapAddExpence(name: categoryName.text!)
    }
    
    //MARK: - setup func
    
    func setupCell() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        addExpenseButton.layer.cornerRadius = 15
    }
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
           print("raw value : \(gesture.state.rawValue)")
           if gesture.state.rawValue == 2 || gesture.state.rawValue == 1 {
               highlight(true)
           }else{
               highlight(false)
           }
           
       }
    
    func highlight(_ touched: Bool) {
        UIView.animate(withDuration: 0.5,
                       delay: -1.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 5.0,
                       options: [.allowUserInteraction],
                       animations: {
                        self.transform = touched ? .init(scaleX: 0.95, y: 0.95) : .identity
        }, completion: nil)
    }
}
