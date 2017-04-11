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
import GoogleSignIn

class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFacebookButtons()
        setupGoogleButtons()
        
        
    }
    
    fileprivate func setupFacebookButtons(){
        //Create login
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x:16, y:350, width: view.frame.width - 32, height:50)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
        self.showEmailAdress()
    }
    
    fileprivate func setupGoogleButtons(){
        //Add google sign in button
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x:16, y:350 + 66, width: view.frame.width - 32, height:50)
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let customButtom = UIButton(type: .system)
        //editing the button
        customButtom.frame = CGRect(x:16, y:350 + 66 + 66, width: view.frame.width - 32, height:50)
        customButtom.backgroundColor = .orange
        customButtom.setTitle("Login with Google+", for: .normal)
        customButtom.setTitleColor(.white, for: .normal)
        customButtom.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        
        customButtom.addTarget(self, action: #selector(handleCustomGoogleSignin), for: .touchUpInside)
        
        view.addSubview(customButtom)

    }
    
    func handleCustomGoogleSignin(){
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    //Delegate implementations
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("DId log out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
        }
        
        showEmailAdress()
    }
    
    func showEmailAdress()
    {
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

