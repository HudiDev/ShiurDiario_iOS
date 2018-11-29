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
    
    let viewModel: DedicationViewModel = DedicationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorder()
        bindViewModel()
        viewModel.getData()
    }
    
    func bindViewModel() {
        viewModel.dedicationItem.bindAndFire {  [weak self]  (dataType) in
            DispatchQueue.main.async {
                switch dataType {
                case .normal(let dedicationStr):
                    self?.titleLabel.text = "A ELEVAÇÃO DA ALMA DE:"
                    self?.nameLabel.text = dedicationStr
                    break
                case .error(let err):
                    self?.nameLabel.text = err.localizedDescription
                    break
                case .empty:
                    self?.nameLabel.text = "No Data Available at this moment"
                    break
                }
            }
        }
    }
    
    func addBorder() {
        container.layer.borderWidth = 0.5
        container.layer.borderColor = UIColor.black.cgColor
    }
}
