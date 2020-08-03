//
//  HomeViewController.swift
//  hitchtravel
//
//  Created by Macbook Pro on 2020-08-03.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import UIKit
import UIKit
import GoogleSignIn
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
                if AccessToken.current != nil{
                    let loginManager = LoginManager()
                    loginManager.logOut()
                    transitionToLoginPage()
                }
                if(GIDSignIn.sharedInstance()?.currentUser != nil){
                    GIDSignIn.sharedInstance()?.signOut()
                    transitionToLoginPage()
                }
                else{
                    let firebaseAuth = Auth.auth()
                    do {
                      try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                      print ("Error signing out: %@", signOutError)
                    }
                    transitionToLoginPage()
                }
                transitionToLoginPage()
    }
        func transitionToLoginPage(){
    
            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! ViewController
            let homePageNav = UINavigationController(rootViewController: homePage)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
            appDelegate.window?.rootViewController = homePageNav
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//
//import UIKit
//import UIKit
//import GoogleSignIn
//import FBSDKLoginKit
//import Firebase
//import FirebaseAuth
//
//
//class HomeViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    @IBAction func logOutTapped(_ sender: Any) {
//        if AccessToken.current != nil{
//            let loginManager = LoginManager()
//            loginManager.logOut()
//            transitionToLoginPage()
//        }
//        if(GIDSignIn.sharedInstance()?.currentUser != nil){
//            GIDSignIn.sharedInstance()?.signOut()
//            transitionToLoginPage()
//        }
//        else{
//            let firebaseAuth = Auth.auth()
//            do {
//              try firebaseAuth.signOut()
//            } catch let signOutError as NSError {
//              print ("Error signing out: %@", signOutError)
//            }
//            transitionToLoginPage()
//        }
//        transitionToLoginPage()
//    }
//    func transitionToLoginPage(){
//
//        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! ViewController
//        let homePageNav = UINavigationController(rootViewController: homePage)
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        appDelegate.window?.rootViewController = homePageNav
//    }
//}
