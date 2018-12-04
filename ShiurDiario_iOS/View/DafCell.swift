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
    

    
    var viewModel: ItemType<DafViewModel>? {
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
    
    func bindViewModel(vm: ItemType<DafViewModel>) {
        switch vm {
        case .normal(let dafViewModel):
            
            dafName_label.text = dafViewModel.dafName
            duration_label.text = dafViewModel.durationText
            hebMonthDay_label.text = dafViewModel.monthDay
            hebYear_label.text = dafViewModel.year
            date_label.text = dafViewModel.dateVM
        case .empty:
            dafName_label.text = "No data avialable"
            
        case .error(let err):
            dafName_label.text = err.localizedDescription
            print("error is: \(err.localizedDescription)")
        }
    }
    
    
}
