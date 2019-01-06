//
//  DedicationViewModel.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/28/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation


class DedicationViewModel {
    
    let dedicationRepo = DedicationRepo()
    
    let dedicationItem = Bindable(ItemType<String>.normal(viewModelData: ""))
    
    func getData() {
        dedicationRepo.retrieveData { (result) in
            switch result {
            case .success(let dedicationStr):
                guard dedicationStr.count > 0 else {
                    self.dedicationItem.value = .empty
                    return
                }
                let nameArr = dedicationStr.components(separatedBy: ":")
                let name = self.generatesStrFromArray(array: nameArr)
                
                self.dedicationItem.value = .normal(viewModelData: name)
                break
            case .failure(let error):
                self.dedicationItem.value = .error(message: error)
                break
            }
        }
    }
    
    private func generatesStrFromArray(array: [String]) -> String {
        var str = ""
        for i in 1 ..< array.count {
            if i > 0 {
                str += array[i]
            }
        }
        return str
    }
}
