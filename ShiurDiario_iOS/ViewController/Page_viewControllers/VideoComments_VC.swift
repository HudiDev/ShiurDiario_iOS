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
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
        getData()
    }
    
    private func getData() {
        guard let dafName = delegate?.daf_name else {
            print("daf name is nil")
            return
        }
        let commentsRef = self.db.collection("dapim").document(dafName).collection("comments")
        
        
        commentsRef.addSnapshotListener { (snapshot, err) in
            
            guard err == nil else {
                print("error could not retrieve data from db: \(err!.localizedDescription)")
                return
            }
            
            self.comments = snapshot!.documents.compactMap {
                return Comment.fromFireBase(document: (id: $0.documentID, data: $0.data()))
            }
        
            self.tableView.reloadData()
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deletCommentAction = UIAlertAction(title: "delete", style: .destructive) { (_) in
            
            guard let dafName = self.delegate?.daf_name else {
                print("daf name is nil")
                return
            }
            
            let commentsRef = self.db.collection("dapim").document(dafName).collection("comments")
            commentsRef.document(self.comments[indexPath.row].id).delete(completion: { (err) in
                guard err == nil else {
                    print("error deleting comment: \(err!.localizedDescription)")
                    return
                }
                
                print("comment with id: \(self.comments[indexPath.row].id), has been successfully deleted")
            })
        }
        
        alert.addAction(deletCommentAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
