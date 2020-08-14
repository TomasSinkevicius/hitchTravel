//
//  SearchViewController.swift
//  hitchtravel
//
//  Created by Macbook Pro on 2020-08-06.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView!
    
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "postCell")
        view.addSubview(tableView)
        
        var layoutGuide:UILayoutGuide!
        
        layoutGuide = view.safeAreaLayoutGuide
        
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        observePosts()

        // Do any additional setup after loading the view.
    }
    func observePosts(){
        print("its working")
        let postsRef = Database.database().reference().child("posts")
        postsRef.observe(.value, with: {snapshot in
            
            var tempPosts = [Post]()
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let uid = author["uid"] as? String,
                    let firstName = author["firstName"] as? String,
                    let lastName = author["lastName"] as? String,
                    let startPoint = dict["startPoint"] as? String,
                    let endPoint = dict["endPoint"] as? String,
                    let time = dict["time"] as? String,
                    let timestamp = dict["timestamp"] as? Double{
                    
                    let userProfile = UserProfile(uid: uid, firstName: firstName, lastName: lastName)
                    let post = Post(id: childSnapshot.key, author: userProfile, startPoint: startPoint, endPoint: endPoint, time: time, timestamp: timestamp)
                    tempPosts.append(post)
                    
                }
            }
            self.posts = tempPosts
            self.tableView.reloadData()
            
        })
    }
//    @IBAction func logOutTapped(_ sender: Any) {
//                if AccessToken.current != nil{
//                    let loginManager = LoginManager()
//                    loginManager.logOut()
//                    transitionToLoginPage()
//                }
//                if(GIDSignIn.sharedInstance()?.currentUser != nil){
//                    GIDSignIn.sharedInstance()?.signOut()
//                    transitionToLoginPage()
//                }
//                else{
//                    let firebaseAuth = Auth.auth()
//                    do {
//                      try firebaseAuth.signOut()
//                    } catch let signOutError as NSError {
//                      print ("Error signing out: %@", signOutError)
//                    }
//                    transitionToLoginPage()
//                }
//        try! Auth.auth().signOut()
//        print("wtf man")
//
//    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        if AccessToken.current != nil{
            let loginManager = LoginManager()
            loginManager.logOut()
            transitionToLoginPage()
            print("logged out of facebook")
        }
        if(GIDSignIn.sharedInstance()?.currentUser != nil){
            GIDSignIn.sharedInstance()?.signOut()
            transitionToLoginPage()
            print("logged out of google")
        }
        else{
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("logged out of standart")
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
                            //transitionToLoginPage()
        }
    }
    func transitionToLoginPage(){
    
            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! ViewController
            let homePageNav = UINavigationController(rootViewController: homePage)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
            appDelegate.window?.rootViewController = homePageNav
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
    
}
