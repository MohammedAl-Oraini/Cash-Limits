//
//  DecimalTextFieldDelegate.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 24/11/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import UIKit

class DecimalTextFieldDelegate: NSObject , UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }

        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1

        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }

        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
}
