//
//  CustomSlider.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 3/20/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSlider: UISlider {
    
    @IBInspectable var handleTintColor: UIColor = .brown {
        
        didSet{
            self.thumbTintColor = handleTintColor
        }
    }
    
    @IBInspectable var sliderThumb: UIImage? {
        
        didSet{
            self.setThumbImage(sliderThumb, for: .normal)
            self.setThumbImage(sliderThumb, for: .highlighted)
        }
    }
    
}
