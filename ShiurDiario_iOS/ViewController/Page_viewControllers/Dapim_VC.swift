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
    var pageNum = 1
    var maxNumPages = 0
    
    let viewModel: DapimViewModel = DapimViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
      
        // TODO: create *2* urlStrings
        
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
        viewModel.dapim.bindAndFire { (data) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                if let maxNumPages = self.viewModel.dapim.value.1 {
                    self.maxNumPages = maxNumPages
                }
            }
        }
    }
    
    
}




extension Dapim_VC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dapim.value.0.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daf_cell", for: indexPath) as! DafCell
        
        cell.viewModel = viewModel.dapim.value.0[indexPath.item]

        return cell
    }
    
}



extension Dapim_VC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DAF ITEM _ SELECTED :)")
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "dafHayomi") as? DafHayomiVC {
            
            switch viewModel.dapim.value.0[indexPath.item] {
            case .normal(let daf):
                vc.prefix = daf.prefixVM
                vc.sqldate = daf.sqlDateVM
                vc.dafName = daf.dafName
                show(vc, sender: self)
                break
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.dapim.value.0.count - 3{
            pageNum += 1
            
            guard pageNum <= maxNumPages else { return }
            
            viewModel.getNextDapim(modelClass: ShiurDafResponse.self, urlString: urlString!, page: pageNum)
        }
    }
}
