//
//  ViewModelItemType.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/29/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation


enum ItemType<T> {
    case normal(itemData: T)
    case error(message: String)
    case empty
}
