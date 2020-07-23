//
//  ViewController.swift
//  hitchtravel
//
//  Created by Macbook Pro on 16/07/2020.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController, LoginButtonDelegate {
    
    

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 44, y: 370, width: view.frame.width - 87, height: 50)
        view.addSubview(loginButton)
        
        loginButton.delegate = self
        loginButton.permissions = ["email", "public_profile"]
        
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("loged out of fb")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if error != nil{
            print("there was an error with fb login")
            return
        }
        print("successful fb login")
        showEmailAdress()
        transitionToHome()
    }
    
    func showEmailAdress(){
        let accessToken = AccessToken.current
        guard let accessTokenString = accessToken?.tokenString else {return}
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials) { (user, error) in
            if error != nil{
                print(error)
                return
            }
            print("Successfuly loged in with our user", user)
        }
        
        GraphRequest.init(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
            if error != nil{
                print("failed to start graph request", error)
                return
            }
            print(result)
        }
    }
    
    @IBAction func GIDSignInButtonTapped(_ sender: Any) {
        transitionToHome()
    }
    func setUpElements(){
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }


}

