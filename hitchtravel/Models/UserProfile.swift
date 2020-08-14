//
//  UserProfile.swift
//  hitchtravel
//
//  Created by Macbook Pro on 2020-08-13.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import Foundation

class UserProfile {
    var uid: String
    var firstName: String
    var lastName: String
    
    init(uid: String, firstName: String, lastName: String) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
    }
}


