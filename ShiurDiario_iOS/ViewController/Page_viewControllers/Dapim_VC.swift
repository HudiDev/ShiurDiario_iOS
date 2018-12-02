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
    
    var sqldate: String?
    var urlString: String?
    var isLoadedFromMasechtotVC: Bool!
    let viewModel: DapimViewModel = DapimViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
      
        if urlString == nil {
            urlString = "http://ws.shiurdiario.com/dafyomi.php?date=\(sqldate!)"
        }
        
        bindViewModel()
        
        if isLoadedFromMasechtotVC {
            viewModel.getData(modelClass: ShiurDafResponse.self, urlString: urlString!)
        } else {
            viewModel.getData(modelClass: PreviousDafResponse.self, urlString: urlString!)
        }
    }
    
    func bindViewModel() {
        viewModel.dapimData.bindAndFire { (data) in
            DispatchQueue.main.async {
                //print("DATA is: \(data)")
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
    
    
}




extension Dapim_VC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dapimData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daf_cell", for: indexPath) as! DafCell
        
        cell.viewModel = viewModel.dapimData.value[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DAF ITEM _ SELECTED :)")
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "dafHayomi") as? DafHayomiVC {
            
            switch viewModel.dapimData.value[indexPath.item] {
            case .normal(let daf):
                vc.prefix = daf.prefixVM
                vc.sqldate = daf.sqlDateVM
                show(vc, sender: self)
                break
            default:
                break
            }
            
        }
        
        
       
    }
    
    
}
