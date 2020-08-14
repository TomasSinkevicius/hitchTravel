//
//  Post.swift
//  hitchtravel
//
//  Created by Macbook Pro on 2020-08-07.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import Foundation

class Post {
    var id: String
    var author: UserProfile
    var startPoint: String
    var endPoint: String
    var time: String
    var timestamp:Double
    
    init(id: String, author: UserProfile, startPoint: String, endPoint: String, time: String, timestamp: Double){
        self.id = id
        self.author = author
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.time = time
        self.timestamp = timestamp
    }
}
