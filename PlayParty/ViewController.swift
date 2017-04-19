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

class ViewController: UIViewController{
    
let facebookButton : FBSDKLoginButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//        facebookButton.isHidden = true
        
        FIRAuth.auth()?.addStateDidChangeListener{ auth, user in
            if let user = user{
                //user is signed in
                // move the user to the home screen
                
                //When you're loged in and oppen the app, goes directly to the profile
//                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
//                //TODO attach the ProfileViewController to the design
//                let ListOfServersViewController:UIViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ListOfServersViewController")
//                self.present(ListOfServersViewController, animated: true, completion: nil)
                
            }else{
                self.setupFacebookButtons()
//                self.setupGoogleButtons()
                
//                self.facebookButton.isHidden = false
            }
        }
    }
    
    fileprivate func setupFacebookButtons(){
        //Create login
//        let facebookButton = FBSDKLoginButton()
        
        self.facebookButton.frame = CGRect(x:16, y:350, width: view.frame.width - 32, height:50)
        self.facebookButton.center = view.center
        
//        self.facebookButton.delegate = self
        self.facebookButton.readPermissions = ["email", "public_profile", "user_friends"]
        self.view!.addSubview(facebookButton)
    
        
        //get profile img
        
        
        self.showEmailAdress()
    }
    
    
    
    //GOOGLE
    
//    fileprivate func setupGoogleButtons(){
//        
//        //Add google sign in button
//        let googleButton = GIDSignInButton()
//        googleButton.frame = CGRect(x:16, y:350 + 66, width: view.frame.width - 32, height:50)
//        //Buttom contraits
//        
//        view.addSubview(googleButton)
//        
//        GIDSignIn.sharedInstance().uiDelegate = self
//        
//
//    }
//    
//    func handleCustomGoogleSignin(){
//        GIDSignIn.sharedInstance().signIn()
//    }
//    
//    
//    func loginButton (_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        if error != nil{
//            print(error)
//        }
//        
//        showEmailAdress()
//        
//    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("DId log out of Facebook")
    }
    
    func showEmailAdress(){
        let acessToken = FBSDKAccessToken.current()
        //Making secure
        guard let acessTokenString = acessToken?.tokenString else {return}
        
        let credentials =
            FIRFacebookAuthProvider.credential(withAccessToken: acessTokenString)
        
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil{
                print("something went wrong with FB user", error ?? "")
                return
            }
            print("Successfully logged in with our user", user ?? "")
        })
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start{
            (connection, result, err) in
            if err != nil{
                print("Failed to start graph request", err ?? "")
                return
            }
            
            print(result ?? "")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//google custom button

//        let customButtom = UIButton(type: .custom)
//
//editing the button
//        customButtom.frame = CGRect(x:16, y:350 + 66 + 66, width: view.frame.width - 32, height:50)
//        customButtom.backgroundColor = .orange
//        customButtom.setTitle("Login with Google+", for: .normal)
//        customButtom.setTitleColor(.white, for: .normal)
//        customButtom.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//
//        customButtom.addTarget(self, action: #selector(handleCustomGoogleSignin), for: .touchUpInside)
//
//        view.addSubview(customButtom)
