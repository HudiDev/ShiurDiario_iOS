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
    var prefix: String?
    var sqldate: String?
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressIndicator.startAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "containerVCsegue" {
            if let vc = segue.destination as? PageVC {
                vc.tabsView = self.tabsView
                vc.prefix = prefix
                vc.sqldate = sqldate
            }
        }
    }
    
    @objc func stopIndicatorAnimation() {
        progressIndicator.stopAnimating()
    }
}





