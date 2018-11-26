//
//  PreviousShiurim_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/23/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class PreviousShiurim_VC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dapim: [DafModel] = []
    var sqldate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func retrieveData() {
        
        if sqldate == nil {
            sqldate = "2018-11-25"
        }
        guard let url = URL(string: "http://ws.shiurdiario.com/dafyomi.php?date=\(sqldate!)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if err != nil {
                print("ERROR IS: \(err?.localizedDescription)")
            }
            
            guard let data = data else { return }
            
            do {
                let dapim = try JSONDecoder().decode(DafResponse.self, from: data)
                print("DAPIM ARE: \(dapim)")
                
                DispatchQueue.main.async {
                    self.dapim = dapim.past_pages
                    self.collectionView.reloadData()
                }
                
            } catch let jsonErr{
                print("JSON ERROR is: \(jsonErr)")
            }
        }.resume()
    }
    
    
}




extension PreviousShiurim_VC: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
