//
//  NavigationBarController.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/20/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit
import PDFKit

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var alert: UIAlertController!
    
    let sideMenuTitles = [("HOME", "home_icon"), ("DAF HAYOMI", "daf_hayomi_icon"), ("SHIURIM", "shiurim_icon"), ("DEDICATORIAS", "dedication_icon"), ("CONTATO", "contact_icon")]

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    

}


extension SideMenuVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell") as! SideMenuCell
        cell.alpha = 0
        cell.tabTitle.text = sideMenuTitles[indexPath.row].0
        
        if let icon = UIImage(named: sideMenuTitles[indexPath.row].1) {
            cell.tabIcon.image = icon
        }
        return cell
    }
}


extension SideMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "dafHayomi")
            show(vc!, sender: self)
            NotificationCenter.default.post(name: NSNotification.Name("hideMenu"), object: nil)
            break
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "allMasechtot_VC")
            show(vc!, sender: self)
            break
        case 3:
            let vc = storyboard?.instantiateViewController(withIdentifier: "dedication_VC")
            show(vc!, sender: self)
            break
        case 4:
            showToast()
            //let vc = storyboard?.instantiateViewController(withIdentifier: "contact_VC")
            //show(vc!, sender: self)
            break
        default:
            print("No such ROW")
        }
    }
    
    private func showToast() {
        
        let alert = UIAlertController(title: nil, message: "Will be available in upcoming versions", preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            alert.dismiss(animated: true)
        }
    }
}
