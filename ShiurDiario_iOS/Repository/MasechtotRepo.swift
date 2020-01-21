//
//  MasechtotRepo.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/29/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation

class MasechtotRepo {
    
    typealias getDataResult = Result<[MasechtaModel]>
    typealias getDataCompletion = ((_ result: getDataResult) -> Void)
    
    func retrieveData(completion: @escaping getDataCompletion) {
        
        guard let url = URL(string: "http://ws.shiurdiario.com/dafyomi.php?date=\(Utils.getCurrentDate())") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard err == nil else {
                print("ERROR IS: \(err!.localizedDescription)")
                completion(.failure(err!))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let masechtot = try JSONDecoder().decode(MasechtaResponse.self, from: data)
                completion(.success(payload: masechtot.d.masechtot))

            } catch let jsonError {
                completion(.failure(jsonError))
                print("JSON-ERROR IS: \(jsonError)")
            }
        }.resume()
    }
}
