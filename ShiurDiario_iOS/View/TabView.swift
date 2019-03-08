//
//  TabView.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/22/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

protocol MenuBarDelegate {
    func menuBarDidSelectItemAt(menu: TabView, index: Int)
}

class TabView: UIView {
    
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    
    
    let titles = ["VÍDEO", "TEXTO DE GUEMARÁ", "AULAS PASSADAS", "LISTA DE TRATADOS"]
    
    var menuDelegate: MenuBarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        tabsCollectionView.delegate = self
        tabsCollectionView.dataSource = self
        
        if let layout = self.tabsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }
}




extension TabView: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuDelegate?.menuBarDidSelectItemAt(menu: self, index: indexPath.item)
        
        let currentCell = collectionView.cellForItem(at: indexPath) as! TitleCell
        
        currentCell.isSelected = true
    }
}
