//
//  VideoComments_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 3/10/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import UIKit
import Firebase

class VideoComments_VC: UITableViewController {
    
    
    private let db: Firestore = Firestore.firestore()
    var ref: DocumentReference? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    

}
