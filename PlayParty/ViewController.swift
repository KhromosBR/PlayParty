//
//  ViewController.swift
//  PlayParty
//
//  Created by Khromos on 2017-04-06.
//  Copyright © 2017 KhromosTech. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, FBSDKLoginButtonDelegate{
    
let facebookButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            
            if (FBSDKAccessToken.current() != nil) {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "login", bundle: nil)
                let loginViewController : UIStoryboard = mainStoryboard.instantiateViewController(withIdentifier: "profileView")
                
                self.profileStoryboard(ProfileViewController, animated: true, completion: nil)
                
                
            }else{
                self.setupFacebookButtons()
        
            }
        }
        

    
}
    
     func setupFacebookButtons(){
        //Create login
//        let facebookButton = FBSDKLoginButton()
        
        self.facebookButton.frame = CGRect(x:16, y:350, width: view.frame.width - 32, height:50)
//        self.facebookButton.center = view.center
        
        self.view!.addSubview(facebookButton)
        self.facebookButton.readPermissions = ["email", "public_profile", "user_friends"]
//        self.facebookButton.delegate = self

        
        //get profile img
        
    }

    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("User loged in")
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            print("User log in Firebase App")
        }
            
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout done")
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

