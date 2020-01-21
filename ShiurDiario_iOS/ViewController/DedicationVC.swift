//
//  DedicationVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/27/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class DedicationVC: ShiurDiarioBaseViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    let viewModel: DedicationViewModel = DedicationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.addBorder(width: 0.5, color: UIColor.black.cgColor)
        bindViewModel()
        viewModel.getData()
    }
    
    func bindViewModel() {
        viewModel.dedicationItem.bindAndFire {  [weak self]  (dataType) in
            DispatchQueue.main.async {
                
                self?.loaderIndicator.stopAnimating()
                
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

}
