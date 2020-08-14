//
//  NewPostViewController.swift
//  hitchtravel
//
//  Created by Macbook Pro on 2020-08-13.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class NewPostViewController:UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var endPointTextField: UITextField!
    @IBOutlet weak var startPointTextField: UITextField!
    
    
    @IBAction func test(_ sender: Any) {

        print("cia viskas gerai")
        guard let userProfile = UserService.currentUserProfile else { return }
        // Firebase code here
        let postRef = Database.database().reference().child("posts").childByAutoId()
        print("cia viskas gerai 1")
        
        
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "firstName": userProfile.firstName,
                "lastName": userProfile.lastName
            ],
            "startPoint": startPointTextField.text as Any,
            "endPoint": endPointTextField.text as Any,
            "time": timeTextField.text as Any,
            "timestamp": [".sv":"timestamp"]
        ] as [String:Any]
        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                print("viskas normaliai")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("kazkas negerai ")
            }
        })
        
        
    }
 
}
