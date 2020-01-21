//
//  DafHayomiVC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/20/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit
import Firebase

class DafHayomiVC: ShiurDiarioBaseViewController {
    
    @IBOutlet weak var tabsView: TabView!
    var prefix: String?
    var sqldate: String?
    var dafName: String?
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressIndicator.startAnimating()
        //setupNavigationBar()
    }
    
    
//    func setupNavigationBar() {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "signout", style: .plain, target: self, action: #selector(signout))
//    }
//    
//    @objc func signout() {
//        guard Auth.auth().currentUser != nil else { return }
//        
//        do {
//            try Auth.auth().signOut()
//            let initialVC = self.storyboard?.instantiateInitialViewController()
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = initialVC
//        } catch _ {
//            self.displayErrorAlert(title: "", msg: "Error occured while attempting to signout")
//        }
//    }
//    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "containerVCsegue" {
            if let vc = segue.destination as? PageVC {
                vc.tabsView = self.tabsView
                vc.prefix = self.prefix
                vc.sqldate = self.sqldate
                vc.dafName = self.dafName
            }
        }
    }
    
    @objc func stopIndicatorAnimation() {
        progressIndicator.stopAnimating()
    }
}





