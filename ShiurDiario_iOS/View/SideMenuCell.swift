//
//  SideMenuCell.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 1/6/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var tabTitle: UILabel!
    @IBOutlet weak var tabIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
