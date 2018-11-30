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
                let name = dedicationStr.components(separatedBy: ":")
                self.dedicationItem.value = .normal(viewModelData: name[1])
                break
            case .failure(let error):
                self.dedicationItem.value = .error(message: error)
                break
            }
        }
    }
}
