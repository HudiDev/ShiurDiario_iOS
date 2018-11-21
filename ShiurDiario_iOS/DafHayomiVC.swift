//
//  DafHayomiVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/20/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class DafHayomiVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var menuBarConstraint: NSLayoutConstraint!
    
    var isSideMenuOpened = false
    
    
    let titles = ["VIDEO", "GEMARA TEXT", "PREVIOUS DAPIM", "ALL MASECHTOT"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath) as! TitleCell
        
        cell.titleLabel.text = titles[indexPath.item]
        
        return cell
    }
    
}
