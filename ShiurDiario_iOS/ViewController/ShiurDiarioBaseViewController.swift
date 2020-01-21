//
//  ShiurDiarioBaseViewController.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 1/21/20.
//  Copyright © 2020 Hudi Ilfeld. All rights reserved.
//

import UIKit
import Firebase

class ShiurDiarioBaseViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "sair", style: .plain, target: self, action: #selector(signout))
    }
    
    @objc func signout() {
        guard Auth.auth().currentUser != nil else { return }
        
        do {
            try Auth.auth().signOut()
            let initialVC = self.storyboard?.instantiateInitialViewController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = initialVC
        } catch _ {
            self.displayErrorAlert(title: "", msg: "Error occured while attempting to signout")
        }
    }
}
