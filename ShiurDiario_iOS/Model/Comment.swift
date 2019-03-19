//
//  Comment.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 3/14/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import Foundation

struct Comment {
    let id: String
    let ownerName: String
    let content: String
    let timeOfComment: String
    
    static func fromFireBase(document: (id: String, data: [String : Any])) -> Comment? {
        
        guard let ownerName = document.data["owner_name"] as? String,
            let content = document.data["content"] as? String,
            let timeOfComment = document.data["time_of_comment"] as? String else { return nil }
        
        return Comment(id: document.id, ownerName: ownerName, content: content, timeOfComment: timeOfComment)
    }
}
