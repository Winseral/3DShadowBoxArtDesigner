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
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Spinner.alpha = 0
   
    }
    
    
    @IBAction func GoogleSignInButton(_ sender: GIDSignInButton) {
        self.Spinner.alpha = 0.85
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        self.Spinner.alpha = 0
        self.present(OrderVC, animated: false, completion: nil)
    }
    
    
    @IBAction func SubmitButton(_ sender: UIButton) {
        let usr = EmailTextField.text
        let pass = PasswordTextField.text
        
        if usr == "" || pass  == ""
        {let alert = UIAlertController(title: "Alert", message: "Email and Password can not be empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)}
        else
        {
        Spinner.alpha = 0.85
        FIRAuth.auth()?.signIn(withEmail: usr!, password: pass!, completion: { (user, Error) in
            
                if let error = Error {
                    self.Spinner.alpha = 0
                    let alert = UIAlertController(title: "Alert", message: "Error logging in - \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }else
                {   self.Spinner.alpha = 0
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
