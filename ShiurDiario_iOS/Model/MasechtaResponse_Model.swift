//
//  Masechta_response.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/25/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

struct MasechtaResponse: Codable {
    let d: d
}

struct d: Codable{
    let masechet: String
    let daf: String
    let prefix: String
    let dedication: String
    let masechtot: [MasechtaModel]
}
