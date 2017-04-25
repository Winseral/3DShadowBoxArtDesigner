//
//  SavedOrder.swift
//  ShadowBoxArtDesigner
//
//  Created by Michael Harvey on 25/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct SavedOrder
{
    //var useruid:String!
    var CCardname: String!
    var CCardnumber: String!
    var CCexpiremonth: String!
    var CCexpireyear: String!
    var CCCVnumber: String!
    var Deliveryaddress: String!
    var Specialnotes: String!
    var Total: Double!
    var Image: String!
    var ref: FIRDatabaseReference?
    var key: String!
    
    init(CCardname: String, CCardnumber: String, CCexpiremonth: String, CCexpireyear: String, CCCVnumber: String, Deliveryaddress: String, Specialnotes: String, Total: Double, Image: String, key: String = "")
    {
    
        self.CCardname = CCardname
        self.CCardnumber = CCardnumber
        self.CCexpiremonth = CCexpiremonth
        self.CCexpireyear = CCexpireyear
        self.CCCVnumber = CCCVnumber
        self.Deliveryaddress = Deliveryaddress
        self.Specialnotes = Specialnotes
        self.Total = Total
        self.Image = Image
        self.key = key
        self.ref = FIRDatabase.database().reference()
        
    }
    
    init(snapshot: FIRDataSnapshot)
    {
        let snapshotValue = snapshot.value! as? NSDictionary
        self.CCardname = snapshotValue!["CCardName"] as! String
        self.CCardnumber = snapshotValue!["CCardNumber"] as! String
        self.CCexpiremonth = snapshotValue!["CCexpireMonth"] as! String
        self.CCexpireyear = snapshotValue!["CCexpireYear"] as! String
        self.CCCVnumber = snapshotValue!["CCardCVNumber"] as! String
        self.Deliveryaddress = snapshotValue!["DeliveryAddress"] as! String
        self.Specialnotes = snapshotValue!["SpecialNotes"] as! String
        self.Total = snapshotValue!["Total"] as! Double
        self.Image = snapshotValue!["Image"] as! String
        self.key = snapshot.key
        self.ref = snapshot.ref
    }
    
    func toanyobject() -> [String: AnyObject]
    {
        return["CCardName": CCardname as AnyObject, "CCardNumber": CCardnumber as AnyObject, "CCexpireMonth": CCexpiremonth as AnyObject, "CCexpireYear": CCexpireyear as AnyObject, "CCardCVNumber": CCCVnumber as AnyObject, "DeliveryAddress": Deliveryaddress as AnyObject, "SpecialNotes": Specialnotes as AnyObject, "Total": Total as AnyObject, "Image": Image as AnyObject]
    }
    
    
    
}
