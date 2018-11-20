//
//  ViewController.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/18/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    var isSideMenuOpened = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    
    @objc func toggleMenu() {
        isSideMenuOpened = !isSideMenuOpened
        if isSideMenuOpened {
            UIView.animate(withDuration: 0.4) {
                self.sideMenuConstraint.constant = -300
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                self.sideMenuConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

