//
//  Utils.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/28/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation


class Utils {
    
    public static func getCurrentDate() -> String{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateInFormat = dateFormatter.string(from: currentDate)
        return dateInFormat
    }
}
