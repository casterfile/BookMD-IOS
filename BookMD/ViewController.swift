//
//  ViewController.swift
//  BookMD
//
//  Created by Anon on 26/05/2017.
//  Copyright © 2017 Anthony Castor. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {
     var dict : NSDictionary!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["email", "public_profile"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoginButton(_ sender: Any) {
        performSegue(withIdentifier: "MainBookMD", sender: self)
    }
    
    @IBAction func RegistrationButton(_ sender: Any) {
        performSegue(withIdentifier: "Registration", sender: self)
    }
    @IBAction func FBLogin(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions:["email", "public_profile"], from: self){
            (result, err) in
            if err != nil {
                print("Custom FB Login failed", err)
                return
            }
            
            self.ShowEmailAddress()
        }

    }
    
    func ShowEmailAddress() {
        print("Successfully logged in with facebook")
        //Grabbing the FB User Info
        FBSDKGraphRequest(graphPath:"/me", parameters:["fields": "id, name, first_name, last_name, picture.type(large), email"]).start{
            (connection, result,err) in
            if err != nil {
                print("Failed to start graph request:", err)
            }
            
            if let data = result as? [String:Any] {
                print(data["id"]!)
                print(data["email"]!)
                print(data["first_name"]!)
                print(data["last_name"]!)
            }
            
            if(result != nil){
                self.performSegue(withIdentifier: "MainBookMD", sender: self)
            }
            
        }
    }

    

}

