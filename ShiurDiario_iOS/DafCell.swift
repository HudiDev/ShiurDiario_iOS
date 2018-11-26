//
//  DafCell.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/25/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class DafCell: UICollectionViewCell {
    
    @IBOutlet weak var dafName_label: UILabel!
    
    @IBOutlet weak var duration_label: UILabel!
    
    @IBOutlet weak var hebMonthDay_label: UILabel!
    
    @IBOutlet weak var hebYear_label: UILabel!
    
    @IBOutlet weak var date_label: UILabel!
    
    override func layoutSubviews() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
