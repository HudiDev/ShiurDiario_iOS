//
//  DedicationRepo.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/29/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation

class DedicationRepo {
    
    
    typealias getDataResult = Result<String>
    typealias getDataCompletion = (_ dedicationName: getDataResult) -> Void
    
    
    func retrieveData(completion: @escaping getDataCompletion) {
        
        guard let url = URL(string: "http://ws.shiurdiario.com/dafyomi.php?date=\(Utils.getCurrentDate())") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("URLSession ERR IS: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let name = try JSONDecoder().decode(MasechtaResponse.self, from: data)
                    completion(.success(payload: name.d.dedication))
                } catch let jsonError {
                    completion(.failure(jsonError))
                    print("JSON_ERR IS: \(jsonError)")
                }
            } else {
                print("NO DATA COMING BACK FROM SERVER")
            }
        }.resume()
    }
}
