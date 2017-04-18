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
    
    var OrderVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "OrderVC")
    
    @IBOutlet weak var GSignInButton: GIDSignInButton!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    
    @IBAction func GoogleSignInButton(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        self.present(OrderVC, animated: false, completion: nil)
    }
    
    
    @IBAction func SubmitButton(_ sender: UIButton) {
        let usr = EmailTextField.text
        let pass = PasswordTextField.text
        
        if usr == "" || pass  == ""
        {print ("send a error message")}
        else
        {
        FIRAuth.auth()?.signIn(withEmail: usr!, password: pass!, completion: { (user, Error) in
            
                if let error = Error {
                    print (error.localizedDescription)
                    return
                }else
                {
                    self.present(self.OrderVC, animated: false, completion: nil)
                    return
                }
            
            })
        }
    }
    
    
    @IBAction func CreateAccountButton(_ sender: UIButton)
    {
        
        //present the CreaetAccountVC when button pressed
        self.present(CreateAccountVC, animated: true, completion: nil)
    }
}
