//
//  Daf_Model.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/25/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

//masechet, daf, date, duration,
//hebmonth, hebdate, hebyear, prefix, sqldate;

struct DafModel: Codable{
    
    let masechet: String
    let daf: String
    let date: String?
    let dafdate: String?
    let duration: String
    let hebmonth: String?
    let hebdate: String?
    let hebyear: String?
    let prefix: String
    let sqldate: String
}
