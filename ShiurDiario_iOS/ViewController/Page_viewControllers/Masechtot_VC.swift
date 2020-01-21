//
//  AllMasechtot_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/23/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class Masechtot_VC: ShiurDiarioBaseViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MasechtotViewModel = MasechtotViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        bindViewModel()
        viewModel.getData()
        
    }
    
    func bindViewModel() {
        viewModel.masechtaData.bindAndFire { (_) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
}




extension Masechtot_VC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.masechtaData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "masechta_cell", for: indexPath) as? MasechtaCell else { return UICollectionViewCell() }
        
        cell.viewModel = viewModel.masechtaData.value[indexPath.item]
        
        return cell
    }
    
}



extension Masechtot_VC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "previousShiurim_VC") as? Dapim_VC {
            switch viewModel.masechtaData.value[indexPath.item] {
            case .normal(let masechta):
                vc.urlString = "http://ws.shiurdiario.com/masechet.php?m=\(masechta.masechetlink)"
                vc.isLoadedFromMasechtotVC = true
                show(vc, sender: self)
                break
            default:
                break
            }
           
        }
    }
}
