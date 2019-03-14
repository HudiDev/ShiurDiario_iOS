//
//  Comment.swift
//  ShiurDiario_iOS
//
//  Created by Hudi Ilfeld on 3/14/19.
//  Copyright © 2019 Hudi Ilfeld. All rights reserved.
//

import Foundation

struct Comment {
    let ownerName: String
    let content: String
    let timeOfComment: String
    
    static func fromFireBase(document: [String : Any]) -> Comment? {
        guard let ownerName = document["owner_name"] as? String,
            let content = document["content"] as? String,
            let timeOfComment = document["time_of_comment"] as? String else { return nil }
        
        return Comment(ownerName: ownerName, content: content, timeOfComment: timeOfComment)
    }
}
