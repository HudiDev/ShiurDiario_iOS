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
    
    override func layoutSubviews() {
        self.addBorder(width: 0.5, color: UIColor.black.cgColor)
    }
    
}
