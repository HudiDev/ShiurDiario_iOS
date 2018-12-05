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
    

    
    var viewModel: DafViewModel? {
        didSet{
            if let viewModel = viewModel {
                bindViewModel(vm: viewModel)
            }
            
        }
    }
    
    override func layoutSubviews() {
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    func bindViewModel(vm: DafViewModel) {
        
        dafName_label.text = vm.dafName
        duration_label.text = vm.durationText
        hebMonthDay_label.text = vm.monthDay
        hebYear_label.text = vm.year
        date_label.text = vm.dateVM
        
    }
    
    
}
