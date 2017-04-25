//
//  OrderVC.swift
//  ShadowBoxArtDesigner
//
//  Created by Michael Harvey on 13/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OrderVC: UIViewController, transfertotalsdelegate {
    
    var DesignVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "DesignVC") as! _DSBADesignerViewC
    var firststart = 0
    var Totalsum = 0.00
    var GrandT = 0.00
    let SpecialNotesColor = UIColor.darkGray

    
    
    //FirebaseDatabase reference
    var dbRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }

    
//OrderVC Outlets
    @IBOutlet var OrderVCView: UIView!
    @IBOutlet weak var TPurchaseView: UIView!
    @IBOutlet weak var SumFlatFlowerText: UILabel!
    @IBOutlet weak var SumLeavesText: UILabel!
    @IBOutlet weak var Sum3DFlowersText: UILabel!
    @IBOutlet weak var SumExtrasText: UILabel!
    @IBOutlet weak var CanvasCost: UILabel!
    @IBOutlet weak var CanvasUIImageView: UIImageView!
    @IBOutlet weak var SumTotal: UILabel!
    @IBOutlet weak var GrandTotal: UILabel!
    @IBOutlet weak var OrderBlur: UIVisualEffectView!
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    
//CreditCard Outlets
    @IBOutlet var CreditCardView: UIView!
    @IBOutlet weak var CCardName: UITextField!
    @IBOutlet weak var CCardNo: UITextField!
    @IBOutlet weak var CCExpiryMonth: UITextField!
    @IBOutlet weak var CCExpiryYear: UITextField!
    @IBOutlet weak var CCCVNo: UITextField!
    
    @IBOutlet weak var CCardCVNo: UITextField!
    @IBOutlet weak var DeliveryAddress: UITextField!
    @IBOutlet weak var SpecialNotes: UITextField!
    @IBOutlet weak var CCConfirmedBtn: UIButton!
    @IBOutlet weak var CCCancelledBtn: UIButton!
    
    
    func transferingtotals(Canvasphoto: UIImage,sumff: Double, suml: Double, sum3df: Double, sume: Double) {
        SumFlatFlowerText.text = String(format: "%.02f",sumff)
        Sum3DFlowersText.text = String(format: "%.02f",sum3df)
        SumLeavesText.text = String(format: "%.02f",suml)
        SumExtrasText.text = String(format: "%.02f",sume)
        CanvasUIImageView.image = Canvasphoto;
        Totalsum = 50 + sumff + sum3df + suml + sume
        SumTotal.text = String(format: "%.02f",Totalsum)
        GrandT = Totalsum + 15
        GrandTotal.text = String(format: "%.02f",GrandT)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DesignVC.delegate = self
        TPurchaseView.layer.cornerRadius = 5
        CreditCardView.layer.cornerRadius = 5
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //firststart is change by Function transferingTotals notfirsttime Int
        if(firststart == 0)
        {
            self.present(DesignVC, animated: false, completion: nil)
            firststart = 1
        }
        OrderVCView.alpha = 1
    }
    @IBAction func CreditCardButton(_ sender: Any) {
        // animates Canvas Menu
        self.view.addSubview(CreditCardView)
        CreditCardView.center = self.view.center
        CreditCardView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        CreditCardView.alpha = 0
        
        UIView.animate(withDuration: 0.7, animations:
            {
                self.OrderBlur.alpha = 0.9
                self.CreditCardView.alpha = 1
                self.CreditCardView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
    }
    
    @IBAction func CreditCardCancelBtn(_ sender: UIButton) {
        CCardName.text = ""
        CCardNo.text = ""
        CCardCVNo.text = ""
        DeliveryAddress.text = ""
        SpecialNotes.text = ""
        
        UIView.animate(withDuration: 1.5, animations:{
            self.CreditCardView.alpha = 0
            self.OrderBlur.alpha = 0
        }) { (hasfinished) in
            if hasfinished
            {self.CreditCardView.removeFromSuperview()}
        }
    }
    
    @IBAction func CancelBtn(_ sender: UIBarButtonItem) {
        self.present(DesignVC, animated: true, completion: nil)
    }
    
    @IBAction func ConfirmedOrderButton(_ sender: UIButton) {
       if(CCardName.text != "" && CCardNo.text != "" && CCExpiryMonth.text != "" && CCExpiryYear.text != "" && CCCVNo.text != "" && CCardCVNo.text != "" && DeliveryAddress.text != "")
       {
        copieddatatofirebase();
       }else
       {
        let alert = UIAlertController(title: "Alert", message: "Error - Credit Card - Name, Number, Month,Year, CV and devliery address can not be nil", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
    }
    
    func copieddatatofirebase()
    {
        //string save image
        let Orderimage = CanvasUIImageView.image
        
        //Convert SavedOrderimage to Compressed NSData - base64String
        let data = UIImageJPEGRepresentation(Orderimage!,0.8)!
        let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        
        let user = FIRAuth.auth()?.currentUser
        if let user = user {
            let uid = user.uid
            let SaveOrder = dbRef.child("SavedOrders").child(uid).childByAutoId()
    
            //send SavedOrder and to this userID Firebase
            let Ordersaved = SavedOrder(CCardname: CCardName.text!, CCardnumber: CCardNo.text!, CCexpiremonth: CCExpiryMonth.text!, CCexpireyear: CCExpiryYear.text!, CCCVnumber: CCCVNo.text!, Deliveryaddress: DeliveryAddress.text!, Specialnotes: SpecialNotes.text!, Total: GrandT, Image: base64String)
            
            SaveOrder.setValue(Ordersaved.toanyobject())
            //SaveSpinner.alpha = 0
            
            let alert = UIAlertController(title: "Order Sent", message: "Your design has been ordered for the amount of \(GrandT) including delivery the order will delivered in three weeks from confirmation of payment to the specified delivery address", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: { 
                self.CreditCardCancelBtn(self.CCConfirmedBtn)
                self.present(self.DesignVC, animated: true, completion: nil)
            })
        }else
        {
            let alert = UIAlertController(title: "Alert", message: "Error - could not save your order at present", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        }
        
    }
}
