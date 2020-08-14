//
//  UsersService.swift
//  hitchtravel
//
//  Created by Macbook Pro on 2020-08-14.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class UserService {
    
    static var currentUserProfile:UserProfile?
    
    static func observeUserProfile(_ uid:String, completion: @escaping ((_ userProfile:UserProfile?)->())) {
        let userRef = Database.database().reference().child("users/profile/\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            var userProfile:UserProfile?
            
            if let dict = snapshot.value as? [String:Any],
                let firstName = dict["firstName"] as? String,
                let lastName = dict["lastName"] as? String{
                
                userProfile = UserProfile(uid: snapshot.key, firstName: firstName, lastName: lastName)
            }
            
            completion(userProfile)
        })
    }
    
}
