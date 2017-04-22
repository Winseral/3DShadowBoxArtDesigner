//
//  OrderVC.swift
//  ShadowBoxArtDesigner
//
//  Created by Michael Harvey on 13/4/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

class OrderVC: UIViewController, transfertotalsdelegate {
    
    var DesignVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "DesignVC") as! _DSBADesignerViewC
    var firststart = 0
    var Totalsum = 0.00
    var GrandT = 0.00
    let SpecialNotesColor = UIColor.darkGray
    
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
    
//CreditCard Outlets
    @IBOutlet var CreditCardView: UIView!
    @IBOutlet weak var CCardName: UITextField!
    @IBOutlet weak var CCardNo: UITextField!
    
    @IBOutlet weak var CCardCVNo: UITextField!
    @IBOutlet weak var DeliveryAddress: UITextField!
    @IBOutlet weak var SpecialNotes: UITextField!
    
    
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
    }
    

}
