//
//  TabsView.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/21/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class TabsView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let titles = ["VIDEO", "GEMARA TEXT", "PREVIOUS DAPIM", "ALL MASECHTOT"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
    

    

}
