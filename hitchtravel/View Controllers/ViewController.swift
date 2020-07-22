//
//  ViewController.swift
//  hitchtravel
//
//  Created by Macbook Pro on 16/07/2020.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        setUpElements()
        // Do any additional setup after loading the view.
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

