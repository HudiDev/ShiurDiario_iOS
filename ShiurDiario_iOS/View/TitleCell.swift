//
//  TitleCell.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/20/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class TitleCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var selectIndicator: UIView!
    
    override var isSelected: Bool {
        didSet{
//            self.selectIndicator.backgroundColor = isSelected ? UIColor.blue : UIColor.white
            titleLabel.layer.borderWidth = 0.8
            
            titleLabel.layer.borderColor = isSelected ? UIColor.black.cgColor : UIColor.white.cgColor
            
        }
    }
    
//    override func layoutSubviews() {
//        //self.addBorder(width: 0.5, color: UIColor.black.cgColor)
//    }
//    
    
}
