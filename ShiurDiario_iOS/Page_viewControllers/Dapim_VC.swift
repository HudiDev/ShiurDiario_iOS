//
//  Dapim_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/23/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class Dapim_VC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dapim: [DafModel] = []
    var sqldate: String?
    var urlString: String?
    var isLoadedFromMasechtotVC: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if sqldate == nil {
            sqldate = "2018-11-25"
        }
        
        if urlString == nil {
            urlString = "http://ws.shiurdiario.com/dafyomi.php?date=\(sqldate!)"
        }
        if isLoadedFromMasechtotVC {
            retrieveData(modelClass: ShiurDafResponse.self, urlString: urlString!)
        } else {
            retrieveData(modelClass: PreviousDafResponse.self, urlString: urlString!)
        }
        
    }
    
    
    func retrieveData<T: Codable>(modelClass: T.Type, urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                print("ERROR IS: \(err?.localizedDescription)")
            }
            
            guard let data = data else { return }
            
            do {
                let dapim = try JSONDecoder().decode(modelClass, from: data)
                print("DAPIM ARE: \(dapim)")
                
                DispatchQueue.main.async {
                    switch dapim {
                        case is ShiurDafResponse:
                            let casted_dapim = dapim as! ShiurDafResponse
                            self.dapim = casted_dapim.dapim
                            break
                        case is PreviousDafResponse:
                            let casted_dapim = dapim as! PreviousDafResponse
                            self.dapim = casted_dapim.past_pages
                            break
                        default:
                            print("MODEL CLASS IS NO TYPE!!")
                            break
                    }
                    self.collectionView.reloadData()
                }
                
            } catch let jsonErr{
                print("JSON ERROR is: \(jsonErr)")
            }
        }.resume()
    }
    
    
}




extension Dapim_VC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dapim.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daf_cell", for: indexPath) as! DafCell
        
        cell.dafName_label.text = "\(dapim[indexPath.item].masechet) \(dapim[indexPath.item].daf)"
        cell.duration_label.text = "Duration: \(dapim[indexPath.item].duration)"
        cell.hebMonthDay_label.text = "\(dapim[indexPath.item].hebmonth) \(dapim[indexPath.item].hebdate)"
        cell.hebYear_label.text = dapim[indexPath.item].hebyear
        cell.date_label.text = dapim[indexPath.item].date
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DAF ITEM _ SELECTED :)")
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "dafHayomi") as? DafHayomiVC {
            
            vc.prefix = dapim[indexPath.item].prefix
            vc.sqldate = dapim[indexPath.item].sqldate
            show(vc, sender: self)
        }
        
        
       
    }
    
    
}
