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
    
    @IBOutlet weak var: UIView!
    
    override var isSelected: Bool {
        didSet{
            self.selectIndicator.backgroundColor = isSelected ? UIColor.blue : UIColor.white
        }
    }
    
    
}
