//
//  NavigationBarController.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 11/20/18.
//  Copyright © 2018 Hudi Ilfeld. All rights reserved.
//

import UIKit
import PDFKit

class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let sideMenuTitles = ["HOME", "DAF HAYOMI", "SHIURIM", "DEDICATORIAS", "CONTATO"]

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = sideMenuTitles[indexPath.row]
        return cell!
    }
    
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
            let vc = storyboard?.instantiateViewController(withIdentifier: "contact_VC")
            show(vc!, sender: self)
            break
        default:
            print("No such ROW")
        }
    }
}
