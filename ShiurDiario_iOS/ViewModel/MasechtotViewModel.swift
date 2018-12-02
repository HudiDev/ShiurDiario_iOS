//
//  MasechtotViewModel.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/30/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation

class MasechtotViewModel {
    
    let masechtotRepo = MasechtotRepo()
    
    let masechtaData = Bindable([ItemType<MasechtaModel>]())
    
    
    func getData() {
        masechtotRepo.retrieveData { (result) in
            switch result {
            case .success(let masechtotArr):
                guard masechtotArr.count > 0 else {
                    self.masechtaData.value = [.empty]
                    return
                }
                
                self.masechtaData.value = masechtotArr.compactMap{
                    .normal(viewModelData: $0)
                }
            
            case .failure(let error):
                self.masechtaData.value = [.error(message: error)]
            }
            
        }
    }
    
}
