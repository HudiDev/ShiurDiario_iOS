//
//  LaunchVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 3/12/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import UIKit
import Firebase

class LaunchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true

        if Auth.auth().currentUser != nil {
            
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "homeVC") else { return }
            navigationController?.pushViewController(vc, animated: true)
        } else {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "signUpVC") else { return }
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
