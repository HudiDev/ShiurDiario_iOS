//
//  Daf_ViewModel.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/30/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation

protocol DafViewModel {
    var dafItem: DafModel { get }
    var dafName: String { get }
    var durationText: String { get }
    var monthDay: String { get }
    var dateVM: String { get }
    var year: String { get }
    var prefixVM: String { get }
    var sqlDateVM: String { get }
}


extension DafModel: DafViewModel {
  
    var dafItem: DafModel {
        return self
    }
    
    var dafName: String {
        return masechet + " " + daf
    }
    
    var durationText: String {
        return "Duration: \(duration)"
    }
    
    var monthDay: String {
        if let month = hebmonth, let day = hebdate {
            return  month + " " + day
        } else {
            return " "
        }
    }
    
    var dateVM: String {
        return (date != nil ? date : dafdate)!
    }
    
    var year: String {
        return hebyear ?? ""
    }
    
    var prefixVM: String {
        return prefix
    }
    
    var sqlDateVM: String {
        return sqldate
    }
    
}
