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
        self.present(DesignVC, animated: true, completion: nil)
    }
}
