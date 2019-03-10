//
//  extensions.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/29/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

extension UIView {
    
    func addBorder(width: CGFloat, color: CGColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
}

extension UIViewController {
    
    func hideKeyBoardWhenTouchedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
}
