//
//  AppDelegate.swift
//  hitchtravel
//
//  Created by Macbook Pro on 16/07/2020.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FBSDKCoreKit
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        
        
        // email login current state listener
        let authListener = Auth.auth().addStateDidChangeListener{ auth,
            user in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if user != nil{
                //
                UserService.observeUserProfile(user!.uid) { userProfile in
                    UserService.currentUserProfile = userProfile
                }
                let controller =
                    storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
            else{
                UserService.currentUserProfile = nil
                let controller =
                    storyboard.instantiateViewController(withIdentifier: "LoginVC") as! ViewController

                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
            }
        }
        
        
        ApplicationDelegate.shared.application(application,didFinishLaunchingWithOptions: launchOptions
        )
        return true
    }
    
    func application(app: UIApplication,open url: URL,options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        let handled = ApplicationDelegate.shared.application( app,open: url,sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return handled
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

