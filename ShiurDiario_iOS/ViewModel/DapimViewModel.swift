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
    
    var dapimTuple: ([ItemType<DafViewModel>], Int?) = (data: [ItemType<DafViewModel>](), maxNum: 0)
    
    let dapim: Bindable<([ItemType<DafViewModel>], Int?)>
    
    init() {
        dapimTuple = ([ItemType<DafViewModel>](), 0)
        dapim = Bindable(dapimTuple)
    }
    
    func getData<T: Codable>(modelClass: T.Type, urlString: String) {
        
        dapimRepository.retrieveData(modelClass: modelClass, urlString: urlString)
        { result, maxNumPages  in
            
            switch result {
                
            case .success(let dapimResult):
                
                guard dapimResult.count > 0 else {
                    self.dapim.value = ([.empty], 0)
                    return
                }
                
                let dataArr: [ItemType<DafViewModel>] = dapimResult.compactMap {
                    .normal(viewModelData: $0 as DafViewModel)
                }
                
                self.dapim.value = (dataArr, maxNumPages)
                
            case .failure(let error):
                self.dapim.value = ([.error(message: error)], 0)
            }
        }
    }
    
    func getNextDapim(urlString: String, page: Int) {
                
        guard page > 0 else { return }
        
        let pageUrl = urlString + "&p=\(page)"
        
        dapimRepository.retrieveData(modelClass: ShiurDafResponse.self, urlString: pageUrl)
        { (result, maxNumPages) in
            
            switch result {
                
            case .success(let dapimResult):
                
                guard dapimResult.count > 0 else {
                    self.dapim.value.0.append(contentsOf: [.empty])
                    return
                }
                
                let dataArr: [ItemType<DafViewModel>] = dapimResult.compactMap {
                    .normal(viewModelData: $0 as DafViewModel)
                }
                
                self.dapim.value.0.append(contentsOf: dataArr)
                                
            case .failure(let error):
                self.dapim.value.0.append(contentsOf: [.error(message: error)])
            }
        }
    }
    
}
