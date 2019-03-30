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
    var maxNumPages = 1
    var hideHeader = false
    var lastIndex: IndexPath?
    
    let viewModel: DapimViewModel = DapimViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MessageCVCell", bundle: nil), forCellWithReuseIdentifier: "msgCell")
        
        
        if urlString == nil {
            urlString = "http://ws.shiurdiario.com/dafyomi.php?date=\(Utils.getCurrentDate())"
        }
        
        bindViewModel()
        
        if isLoadedFromMasechtotVC {
            viewModel.getData(modelClass: ShiurDafResponse.self, urlString: urlString!)
        } else {
            viewModel.getData(modelClass: PreviousDafResponse.self, urlString: urlString!)
        }
    }
    
    func bindViewModel() {
        viewModel.dapim.bindAndFire { [weak self] (data) in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                if let maxNumPages = self?.viewModel.dapim.value.1 {
                    self?.maxNumPages = maxNumPages
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
        
        
        switch viewModel.dapim.value.0[indexPath.item] {
        case .normal(let dafViewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daf_cell", for: indexPath) as! DafCell
            cell.viewModel = dafViewModel
            return cell
        case .empty:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "msgCell", for: indexPath) as! MessageCVCell
            cell.msgLabel.text = "No data avialable"
            return cell
        case .error(let err):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "msgCell", for: indexPath) as! MessageCVCell
            cell.msgLabel.text = err.localizedDescription
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loader", for: indexPath)
        
        return footer
    }
    

    
}



extension Dapim_VC: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
            
            guard pageNum <= maxNumPages else {
                return
            }
            
            viewModel.getNextDapim(urlString: urlString!, page: pageNum)
            
            
            
        }
    }
            
}

extension Dapim_VC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard pageNum < maxNumPages else {
            return CGSize(width: 0, height: 0)
        }
        
        return CGSize(width: 50, height: 50)
    }
}


