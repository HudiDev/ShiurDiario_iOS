//
//  DedicationViewModel.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/28/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import Foundation

struct Animal {
    var breed: String
    var gender: String
}

class DedicationViewModel {
    
    private var dedicationName: String
    
    init() {
        retrieveData { (arr) in
            dedicationName = arr[1]
        }
    }
}





extension DedicationViewModel {
    
    func retrieveData(completion: @escaping (_ dedicationName: [String]) -> Void) {
        
        guard let url = URL(string: "http://ws.shiurdiario.com/dafyomi.php?date=\(Utils.getCurrentDate())") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                print("URLSession ERR IS: \(err!.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let name = try JSONDecoder().decode(MasechtaResponse.self, from: data)
                    let dedicationArr =  name.d.dedication.components(separatedBy: ":")
                    completion(dedicationArr)
                } catch let jsonError {
                    print("JSON_ERR IS: \(jsonError)")
                }
            } else {
                print("NO DATA COMING BACK FROM SERVER")
            }
            
            }.resume()
    }
}
