//
//  VideoComments_VC.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 3/10/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import UIKit
import Firebase


protocol DafNameDelegate {
    var daf_name: String { get }
}

class VideoComments_VC: UITableViewController {

    
    private let db: Firestore = Firestore.firestore()
    var ref: DocumentReference? = nil
    var comments: [Comment] = [Comment]()
    var delegate: DafNameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData() {
        guard let dafName = delegate?.daf_name else {
            print("daf name is nil")
            return
        }
        let commentsRef = self.db.collection("dapim").document(dafName).collection("comments")
        commentsRef.getDocuments { (snapshot, err) in
            guard err == nil else {
                print("error could not retrieve data from db: \(err!.localizedDescription)")
                return
            }
            for (index, doc) in snapshot!.documents.enumerated() {
                print("doc at \(index) is: \(doc.data())")
                guard let comment = Comment.fromFireBase(document: doc.data()) else { print("comment from firebase is null")
                    return
                }
                self.comments.append(comment)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseIdentifier) as? CommentCell{
            cell.bindData(comment: self.comments[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
