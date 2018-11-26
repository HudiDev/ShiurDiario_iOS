//
//  Daf_response.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/25/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

struct PreviousDafResponse: Codable {
    let past_pages: [DafModel]
}


struct ShiurDafResponse: Codable {
    let dapim: [DafModel]
}
