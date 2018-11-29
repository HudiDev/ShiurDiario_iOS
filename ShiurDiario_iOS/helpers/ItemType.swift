//
//  ItemType.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/29/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation


enum ItemType<T> {
    case normal(viewModelData: T)
    case error(message: Error)
    case empty
}
