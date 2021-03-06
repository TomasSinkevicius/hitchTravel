//
//  SignUpViewController.swift
//  hitchtravel
//
//  Created by Macbook Pro on 16/07/2020.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    // Check the field and validate that data is correct. If everything is correct this method returns nil otherwise error message.
    func validateField() -> String? {
        
        // Check that all field are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        
        // Check if password is secure
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
            // Password isint secure enough
            return "Please make sure your password has 8 letters and a number"
        }
        
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = validateField()
        
        if error != nil{
            
            showError(message: error!)
        }
        else{
            
            // Create cleaned versions of the data
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                if error != nil{
                    
                    // There was an error creating the user
                   self.showError(message: error!.localizedDescription)
                }
                else{
                    // User was created successfuly
                    // Saving to firestore database
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "email": email, "password": password, "uid": result!.user.uid], completion: { (error) in
                        if error != nil{
                            self.showError(message: "ERROR saving user data")
                        }
                    })
                    //self.transitionToHome()
                    // Saving to realtime database
                    self.saveProfile(firstName: firstName, lastName: lastName, email: email, password: password){ success in
                        if success{
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    func showError( message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func saveProfile(firstName: String, lastName: String, email: String, password: String, completion: @escaping ((_ success: Bool)->())) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "firstName": firstName,
            "lastName" : lastName,
            "email" : email,
            "password" : password
            
        ] as [String:Any]
        databaseRef.setValue(userObject) {error, ref in
            completion(error == nil)
        }
        
    }
    
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
