//
//  ProfileViewController.swift
//  PlayParty
//
//  Created by Khromos on 2017-04-21.
//  Copyright © 2017 KhromosTech. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    @IBAction func didLogOut(_ sender: Any) {
        //Sign the user out of firebase
        try! FIRAuth.auth()!.signOut()
        //sign the user out of facebook
        FBSDKAccessToken.setCurrent(nil)
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "loginView", bundle: nil)
//        let profileStoryboard : UIStoryboard = mainStoryboard.instantiateViewController(withIdentifier: "profileView")
//        
//        self.profileStoryboard(ProfileViewController as! UIStoryboard, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
