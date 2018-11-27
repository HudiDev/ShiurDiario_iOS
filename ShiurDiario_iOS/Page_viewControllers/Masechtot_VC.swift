//
//  AllMasechtot_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/23/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class Masechtot_VC: UIViewController {
    
    var masechtot: [MasechtaModel] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        retrieveData()
        
    }
    
    func retrieveData() {
        
        guard let url = URL(string: "http://ws.shiurdiario.com/dafyomi.php?date=2018-11-25") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if err != nil {
                print("ERROR IS: \(err!.localizedDescription)")
            }
            
            guard let data = data else { return }
            
            do {
                 let masechtot = try JSONDecoder().decode(MasechtaResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.masechtot = masechtot.d.masechtot
                    self.collectionView.reloadData()
                }
            } catch let jsonError {
                print("JSON-ERROR IS: \(jsonError)")
            }
        }.resume()
    }
}






extension Masechtot_VC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return masechtot.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "masechta_cell", for: indexPath) as! MasechtaCell
        
        cell.masechtaLabel.text = masechtot[indexPath.item].masechet
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "previousShiurim_VC") as? Dapim_VC {
            vc.urlString = "http://ws.shiurdiario.com/masechet.php?m=\(masechtot[indexPath.item].masechetlink)"
            vc.isLoadedFromMasechtotVC = true
            show(vc, sender: self)
        }
        
    }
}
