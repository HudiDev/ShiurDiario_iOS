//
//  CommentCell.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 3/10/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    
    static public let reuseIdentifier = "commentCell"
    
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var commentTime: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.content.sizeToFit()
        self.content.layer.cornerRadius = 5
        self.content.clipsToBounds = true
    }
    
    func bindData(comment: Comment) {
        self.owner.text = comment.ownerName
        self.content.text = comment.content
        self.commentTime.text = comment.timeOfComment
    }
}



