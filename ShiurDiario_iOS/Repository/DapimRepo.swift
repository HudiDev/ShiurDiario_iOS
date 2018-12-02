//
//  DapimRepo.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/30/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation


class DapimRepo {

    
    typealias getDataResult = Result<[DafModel]>
    typealias getDataCompletion = ((_ result: getDataResult) -> Void)

   
    func retrieveData<T: Codable>(modelClass: T.Type, urlString: String, completion: @escaping getDataCompletion) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            guard let data = data else { return }
            
            do {
                
                let dapim = try JSONDecoder().decode(modelClass, from: data)
                
                switch dapim {
                case is ShiurDafResponse:
                    let casted_dapim = dapim as! ShiurDafResponse
                    completion(.success(payload: casted_dapim.dapim))
                    break
                case is PreviousDafResponse:
                    let casted_dapim = dapim as! PreviousDafResponse
                    completion(.success(payload: casted_dapim.past_pages))
                    break
                default:
                    break
                }

            } catch let jsonErr{
                completion(.failure(jsonErr))
            }
            
        }.resume()
    }
}
