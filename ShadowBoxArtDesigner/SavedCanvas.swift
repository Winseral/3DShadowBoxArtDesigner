//
//  SavedCanvas.swift
//  ShadowBoxArtDesigner
//
//  Created by Michael Harvey on 19/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct SavedCanvas
{
    //var useruid:String!
    var canvasname: String!
    var savedimage: String!
    var saved3dflowerssum: Double!
    var savedflatflowerssum: Double!
    var savedleavessum: Double!
    var savedextrassum: Double!
    var ref: FIRDatabaseReference?
    var key: String!
    
    init(canvasname: String, savedimage: String, saved3dflowerssum: Double, savedflatflowerssum: Double, savedleavessum: Double, savedextrassum: Double, key: String = "")
    {
        //self.useruid = useruid
        self.canvasname = canvasname
        self.savedimage = savedimage
        self.saved3dflowerssum = saved3dflowerssum
        self.savedflatflowerssum = savedflatflowerssum
        self.savedleavessum = savedleavessum
        self.savedextrassum = savedextrassum
        self.key = key
        self.ref = FIRDatabase.database().reference()
        
    }
    
    init(snapshot: FIRDataSnapshot)
    {
        let snapshotValue = snapshot.value! as? NSDictionary
        //self.useruid = snapshotValue!["useruid"] as! String
        self.canvasname = snapshotValue!["canvasname"] as! String
        self.savedimage = snapshotValue!["savedimage"] as! String
        self.saved3dflowerssum = snapshotValue!["saved3dflowerssum"] as! Double
        self.savedflatflowerssum = snapshotValue!["savedflatflowerssum"] as! Double
        self.savedleavessum = snapshotValue!["savedleavessum"] as! Double
        self.savedextrassum = snapshotValue!["savedextrassum"] as! Double
        self.key = snapshot.key
        self.ref = snapshot.ref
    }
    
    func toanyobject() -> [String: AnyObject]
    {
        return["canvasname": canvasname as AnyObject, "savedimage": savedimage as AnyObject, "saved3dflowerssum": saved3dflowerssum as AnyObject, "savedflatflowerssum": savedflatflowerssum as AnyObject, "savedleavessum": savedleavessum as AnyObject, "savedextrasum": savedextrassum as AnyObject]
    }
    
    
    
}




