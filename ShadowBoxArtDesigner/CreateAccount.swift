//
//  CreateAccount.swift
//  ShadowBoxArtDesigner
//
//  Created by Michael Harvey on 2/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class CreateAccount: UIViewController {
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    
    //create unbound seque to DesignVC Account
    var DesignVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DesignVC")

    override func viewDidLoad() {
        super.viewDidLoad()
        Spinner.alpha = 0}

    @IBAction func ReturnMainMenuButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)}

    @IBAction func SubmitButton(_ sender: UIButton) {
        let usr = EmailTextField.text
        let pass = PasswordTextField.text
        
        if usr == "" || (pass?.characters.count)! < 6
        {let alert = UIAlertController(title: "Alert", message: "Email and Password can not be empty and Password must be more than six characters", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)}
        else{
            self.Spinner.alpha = 0.85
            FIRAuth.auth()?.createUser(withEmail: usr!, password: pass!) { (user, error) in
            if let error = error
            {self.Spinner.alpha = 0
            let alert = UIAlertController(title: "Alert", message: "Error Signing up - \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            }
            self.Spinner.alpha = 0
            let alert = UIAlertController(title: "Thank You", message: "You have created account \(user!.email!)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                    self.present(self.DesignVC, animated: true, completion: nil)
                    }))
            self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
