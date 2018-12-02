//
//  DapimViewModel.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 12/2/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation



class DapimViewModel {
    
    let dapimRepository = DapimRepo()
    
    let dapimData = Bindable([ItemType<DafViewModel>]())
    
    func getData<T: Codable>(modelClass: T.Type, urlString: String) {
        dapimRepository.retrieveData(modelClass: modelClass, urlString: urlString)
        { (result) in
            switch result {
                
            case .success(let dapimResult):
                
                guard dapimResult.count > 0 else {
                    self.dapimData.value = [.empty]
                    return
                }
                
                self.dapimData.value = dapimResult.compactMap {
                    .normal(viewModelData: $0 as DafViewModel)
                }
                
            case .failure(let error):
                self.dapimData.value = [.error(message: error)]
            }
            
        }
    }
}
