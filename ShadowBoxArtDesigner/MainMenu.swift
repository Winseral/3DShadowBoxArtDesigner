//
//  MainMenu.swift
//  ShadowBoxArtDesigner
//
//  Created by Michael Harvey on 2/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class MainMenu: UIViewController, GIDSignInUIDelegate{
   
    //create unbound seque to Create Account
    var CreateAccountVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateAccountVC")
    
    var DesignVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "DesignVC")
    
    @IBOutlet weak var GSignInButton: GIDSignInButton!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    
    @IBAction func GoogleSignInButton(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        self.present(DesignVC, animated: true, completion: nil)
    }
    
    
    @IBAction func SubmitButton(_ sender: UIButton) {
    }
    
    
    @IBAction func CreateAccountButton(_ sender: UIButton)
    {
        
        //present the CreaetAccountVC when button pressed
        self.present(CreateAccountVC, animated: true, completion: nil)
    }
}
