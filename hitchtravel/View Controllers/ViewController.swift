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
import FirebaseAuth

class ViewController: UIViewController, LoginButtonDelegate, GIDSignInDelegate {
    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID

        googleButtonSetUp()
        facebookButtonSetUp()

        setUpElements()
    }
    
    // This somehow has to be moved to app delegate
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AccessToken.current != nil{
            print("You are signed in with facebook")
            transitionToHomeTabBar()
        }
        if GIDSignIn.sharedInstance()?.currentUser != nil{
            print("You are signed in with google")
            transitionToHomeTabBar()
        }
    }

    func transitionToLoginPage(){
        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! ViewController
        let homePageNav = UINavigationController(rootViewController: homePage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.window?.rootViewController = homePageNav
    }
    func transitionToHomePage(){
        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        let homePageNav = UINavigationController(rootViewController: homePage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.window?.rootViewController = homePageNav
    }
    
    func transitionToHomeTabBar(){
        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        let homePageNav = UINavigationController(rootViewController: homePage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.window?.rootViewController = homePageNav
    }
    
    func googleButtonSetUp(){
        let googleLoginButton = GIDSignInButton()
        googleLoginButton.frame = CGRect(x: 44, y: 300, width: view.frame.width - 87, height: 50)
        view.addSubview(googleLoginButton)
    }
    func facebookButtonSetUp(){
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 44, y: 370, width: view.frame.width - 87, height: 50)
        view.addSubview(loginButton)
        loginButton.delegate = self
        loginButton.permissions = ["email", "public_profile"]
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
           // ...
           if let error = error {
            print(error.localizedDescription)
               return
           }
           else{
            print("You are signed in")
            //self.transitionToHomePage()
           }
           guard let authentication = user.authentication else { return }
           let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
           Auth.auth().signIn(with: credential) { (user, error) in
               if let error = error{
                print(error.localizedDescription)
               }
               else{
                print("Successfuly created firebase user with google account")
               }
           }
       }

       func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
           // Perform any operations when the user disconnects from app here.
           // ...
       }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("loged out of fb")
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

        if error != nil{
            print("there was an error with fb login")
            return
        }
        print("there was no error with fb login")
        showEmailAdress()
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
            //self.transitionToHomePage()
        }
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

