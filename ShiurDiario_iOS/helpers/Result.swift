//
//  Result.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/29/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(payload: T)
    case failure(Error)
}
