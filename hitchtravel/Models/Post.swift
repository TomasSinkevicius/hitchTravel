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
    var author: String
    var startDestination: String
    var endDestination: String
    var time: String
    
    init(id: String, author: String, startDestination: String, endDestination: String, time: String){
        self.id = id
        self.author = author
        self.startDestination = startDestination
        self.endDestination = endDestination
        self.time = time
    }
}
