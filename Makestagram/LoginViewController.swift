//
//  LoginvViewController.swift
//  Makestagram
//
//  Created by Chenyang Zhang on 6/28/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//
import Foundation
import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase
import FirebaseFacebookAuthUI
import FirebaseGoogleAuthUI

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let authUI = FUIAuth.defaultAuthUI()
            else {return}
        authUI.delegate = self
        
        let providers: [FUIAuthProvider] = [FUIGoogleAuth(), FUIFacebookAuth()]
        authUI.providers = providers
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in \(error.localizedDescription)")
    
        }
        guard let user = user
            else {return}
//        let userRef = Database.database().reference().child("users").child(user.uid)
//        userRef.observeSingleEvent(of: .value, with: {(snapshot) in
//            if let user = User(snapshot: snapshot) {
//                
//                print("Welcome back \(user.username).")
//            } else {self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//            }
//        })
//        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
//            if let _ = User(snapshot: snapshot) {
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                
//                if let initialViewController = storyboard.instantiateInitialViewController() {
//                    self.view.window?.rootViewController = initialViewController
//                    self.view.window?.makeKeyAndVisible()
//                }
//            } else {
//                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//            }
//        })
        UserService.show(forUID: user.uid) { (user) in
        if let user = user {
                //handle existing users
                User.setCurrent(user, writeToUserDefaults: true)
                
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
            } else {
                //handle new users
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
    }
    
}



















