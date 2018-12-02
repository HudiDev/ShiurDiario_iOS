//
//  MasechtaCell.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/25/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class MasechtaCell: UICollectionViewCell {
    
    @IBOutlet weak var masechtaLabel: UILabel!
    
    var viewModel: ItemType<MasechtaModel>? {
        didSet {
            bindViewModel()
        }
    }
    
    override func layoutSubviews() {
        self.addBorder(width: 0.5, color: UIColor.black.cgColor)
    }
    
    func bindViewModel() {
        switch viewModel! {
        case .normal(let masechta):
            masechtaLabel.text = masechta.masechet
            break
        case .empty:
            masechtaLabel.text = "No Data to Display at this moment"
            break
        case .error(let err):
            masechtaLabel.text = err.localizedDescription
            break
        }
    }
    
}
