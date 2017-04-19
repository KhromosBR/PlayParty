//
//  ProfileViewController.swift
//  PlayParty
//
//  Created by Khromos on 2017-04-12.
//  Copyright © 2017 KhromosTech. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    
    @IBAction func logOutButton(_ sender: Any) {
       
        try! FIRAuth.auth()!.signOut()
        
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
