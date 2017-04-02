//
//  3DSBADesignerViewC.swift
//  ShadowBoxArtDesigner
//
//  Created by Michael Harvey on 31/3/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn


class _DSBADesignerViewC: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
       
    }
    
}
