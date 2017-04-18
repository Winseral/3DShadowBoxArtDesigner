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
    
    //create unbound seque to DesignVC Account
    var DesignVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DesignVC")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func ReturnMainMenuButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func SubmitButton(_ sender: UIButton) {
        let usr = EmailTextField.text
        let pass = PasswordTextField.text
        
        if usr == "" || (pass?.characters.count)! < 6
        {print ("send a error message Password must be 6 or more characters")}
        else{
        FIRAuth.auth()?.createUser(withEmail: usr!, password: pass!) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("\(user!.email!) created")
            }
        self.present(DesignVC, animated: true, completion: nil)
        }
    }
}
