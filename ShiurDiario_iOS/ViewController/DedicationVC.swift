//
//  DedicationVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/27/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class DedicationVC: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    
    var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorder()
     
        retrieveData { (arr) in
            DispatchQueue.main.async {
                self.titleLabel.text = "A ELEVAÇÃO DA ALMA DE:"
                self.nameLabel.text = arr[1]
            }
        }
    }
    
    func addBorder() {
        container.layer.borderWidth = 0.5
        container.layer.borderColor = UIColor.black.cgColor
    }
}
