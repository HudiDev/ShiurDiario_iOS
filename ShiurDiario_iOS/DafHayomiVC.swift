//
//  DafHayomiVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/20/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit

class DafHayomiVC: UIViewController {
    
    @IBOutlet weak var tabsView: TabView!
    
    override func viewDidLoad() {
        super.viewDidLoad()    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "containerVCsegue" {
            if let vc = segue.destination as? pageVC {
                vc.tabsView = self.tabsView
            }
        }
        
    }
}





