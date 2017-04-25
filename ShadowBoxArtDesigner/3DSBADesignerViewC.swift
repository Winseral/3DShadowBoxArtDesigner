//
//  3DSBADesignerViewC.swift
//  ShadowBoxArtDesigner
//
//  Created by Michael Harvey on 31/3/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class _DSBADesignerViewC: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    
    //FirebaseDatabase reference
    var dbRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    
    //transfer totals delegate
    var delegate: transfertotalsdelegate?
    

    let Flat_Flowers: [UIImage] = [UIImage(named:"Flat_SingleLayer_VerySmall_Crystal_Bud.png")!, UIImage(named:"Flat_ThreeLayers.png")!, UIImage(named:"Flat_TwoLayeredBud.png")!, UIImage(named:"Flat_TwoLeaf_Bud.png")!, UIImage(named:"Flat_SingleLayer_Small_Flower.png")!,UIImage(named:"Flat_ThreeLayers_vinedBud.png")!, UIImage(named:"Flat_ThreeLayer_Small_Flower.png")!, UIImage(named:"Flat_SixStar_Large_Flower.png")!, UIImage(named:"Flat_SixStar_Small_Flower.png")!]
    let Flat_Flowers_Costs = [0.10,0.20,0.20,0.30,0.10,0.30,0.40,0.20,0.10]
    
    let Leaves:[UIImage] = [UIImage(named:"Flat_Leaf.png")!, UIImage(named:"Flat_SevenLeaf_Leaf.png")!, UIImage(named:"Flat_SevenLeaf_Leaf2.png")!,UIImage(named:"Flat_SingleLeaf_CentreCutout_Leaf.png")!, UIImage(named:"Flat_Small_Single_Leaf.png")!,UIImage(named:"Flat_Standard_Leaf.png")!, UIImage(named:"Single_Small_Pet_Leaf.png")!]
    let Leaves_Costs = [0.10,0.10,0.10,0.15,0.10,0.10,0.05]
    
    let D3_Flowers: [UIImage] = [UIImage(named:"3D_Pet_Bud.png")!,UIImage(named:"3D_MultiLayered_Flower_Large.png")!,UIImage(named:"3D_FourLayered_Flower_Small.png")!, UIImage(named:"3D_ThreeLayered_Flower_Small.png")!]
    let D3_Flowers_Costs = [0.60,0.50,0.50,0.60]
    
    let Extras:[UIImage] = [UIImage(named:"Flat_LargeButterfly.png")!, UIImage(named:"Extras_CutOut_Flower.png")!, UIImage(named:"Extra_Pattern.png")!, UIImage(named:"Extras_Large_Feather.png")!, UIImage(named:"Extras_Smaller_Feather.png")!]
    let Extras_Costs = [0.45,0.30,0.40,0.30,0.25]
    
    let CanvasColourPicker: NSDictionary = ["Purple": UIImage(named:"Card_Purple.png")!, "Rose": UIImage(named:"Card_Rose.png")!, "White":UIImage(named:"Card_White.png")!, "Light Pink": UIImage(named:"Card_Pink_Light.png")!, "Dark Pink ":UIImage(named:"Card_Pink_Dark")!, "Dark Green": UIImage(named:"Card_Green_Dark")!, "Green": UIImage(named:"Card_Green_Flat.png")!, "Light Green": UIImage(named:"Card_Green_Lightest")!, "Grass Green": UIImage(named:"Card_Green_Grass_Flat")!]

    //vars
    var Listclicktest = 0
    var countimages = 0
    var valueSelected = 0
    var notfirsttime = 0
    
    var sumFlat_Flowers = 0.00
    var sumLeaves = 0.00
    var sumD3_Flowers = 0.00
    var sumExtras = 0.00
    
    var newimage = UIImage()
    var newuiimageView: [UIImageView] = []
    var SavedCanvasScreenShot = UIImage()
    
    
    //let
    let backbuttonimage = UIImage(named:"ButtonBackground.png")!
    let selectbuttonimage = UIImage(named:"SelectedButton.png")!
    
    @IBOutlet weak var ImagePicker: AKPickerView!
    
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var CanvasView: UIView!
    @IBOutlet weak var CanvasImage: UIImageView!
    
    //Label outlets
    @IBOutlet weak var PickerLabel: UILabel!
    
    //button outlets Buttons
    @IBOutlet weak var ListButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    
    //pick list buttons
    @IBOutlet weak var FlatFlowersButton: UIButton!
    @IBOutlet weak var D3FlowersButton: UIButton!
    @IBOutlet weak var LeavesButton: UIButton!
    @IBOutlet weak var ExtrasButton: UIButton!
    
    //Save Menu
    @IBOutlet var SaveMenu: UIView!
    @IBOutlet weak var SaveFileName: UITextField!
    @IBOutlet weak var SavetoFileButton: UIButton!
    @IBOutlet weak var SaveSpinner: UIActivityIndicatorView!
    
    
    //button outlet Canvas
    @IBOutlet weak var CanvasButton: UIButton!
    @IBOutlet var CanvasMenu: UIView!
    @IBOutlet weak var CanvasOrderButton: UIButton!
    @IBOutlet weak var CanvasClearButton: UIButton!
    @IBOutlet weak var CanvasLoadButton: UIButton!
    @IBOutlet weak var CanvasSpinner: UIActivityIndicatorView!
    @IBOutlet weak var CanvasColourButton: UIButton!
    
    //Canvas Colour Picker
    @IBOutlet var CanvasColourPickerView: UIView!
    @IBOutlet weak var CanvasCPicker: UIPickerView!
    @IBOutlet weak var CanvasColourCancelButton: UIButton!
    
    //Gesture outlets
    @IBOutlet var DoubleTap: UITapGestureRecognizer!

    //Menu outlets
    @IBOutlet weak var ListMenu: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(DT))
        tap.numberOfTapsRequired = 2
        
        ImagePicker.delegate = self
        ImagePicker.dataSource = self
        ImagePicker.layer.cornerRadius = 5
        ImagePicker.layer.shadowRadius = 2
        ImagePicker.addGestureRecognizer(tap)
        
        CanvasCPicker.delegate = self
        CanvasCPicker.dataSource = self
        
        CanvasMenu.layer.cornerRadius = 5
        SaveMenu.layer.cornerRadius = 5
        CanvasColourPickerView.layer.cornerRadius = 5
        CanvasSpinner.alpha = 0
        SaveSpinner.alpha = 0
        
                
    }
    
//AKPicker Horiztonal Picker for materials
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        
        if Listclicktest == 1
        {return Leaves.count}
        else if Listclicktest == 2
        {return D3_Flowers.count}
        else if Listclicktest == 3
        {return Extras.count}
        else{return Flat_Flowers.count}
    }
    
    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        
        if Listclicktest == 1
        {return Leaves[item]}
        else if Listclicktest == 2
        {return D3_Flowers[item]}
        else if Listclicktest == 3
        {return Extras[item]}
        else{return Flat_Flowers[item]}
    }
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        valueSelected = item
    }
    
//Picker for Canvas Colour
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: (CanvasColourPicker.allKeys[row] as? String)!, attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CanvasColourPicker.count
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CanvasImage.image = CanvasColourPicker.allValues[row] as? UIImage}
    

//List Menu and its buttons
    @IBAction func ListBtn(_ sender: UIButton) {
        if(ListButton.backgroundImage(for: .selected) != selectbuttonimage)
        {ListButton.setBackgroundImage(selectbuttonimage, for: .normal)
        ListMenu.alpha = 1}
        else{ListButton.setBackgroundImage(backbuttonimage, for: .normal)
        ListMenu.alpha = 0}}
    
    @IBAction func FlatFlowersBtn(_ sender: UIButton) {
        restListButtonBackgroundImages()
        FlatFlowersButton.setBackgroundImage(selectbuttonimage, for: .normal)
        PickerLabel.text = "Flat Flowers"
        Listclicktest = 0
        ImagePicker.selectItem(0, animated: true)}

    @IBAction func LeavesBtn(_ sender: UIButton) {
        restListButtonBackgroundImages()
        LeavesButton.setBackgroundImage(selectbuttonimage, for: .normal)
        PickerLabel.text = "Leaves"
        Listclicktest = 1
        ImagePicker.selectItem(0, animated: true)}
    
    @IBAction func D3FlowersBtn(_ sender: UIButton) {
        restListButtonBackgroundImages()
        D3FlowersButton.setBackgroundImage(selectbuttonimage, for: .normal)
        PickerLabel.text = "3D Flowers"
        Listclicktest = 2
        ImagePicker.selectItem(0, animated: true)}
    
    @IBAction func ExtrasBtn(_ sender: UIButton) {
        restListButtonBackgroundImages()
        ExtrasButton.setBackgroundImage(selectbuttonimage, for: .normal)
        PickerLabel.text = "Extras"
        Listclicktest = 3
        ImagePicker.selectItem(0, animated: true)}

    func restListButtonBackgroundImages()
    {
    FlatFlowersButton.setBackgroundImage(backbuttonimage, for: .normal)
    LeavesButton.setBackgroundImage(backbuttonimage, for: .normal)
    D3FlowersButton.setBackgroundImage(backbuttonimage, for: .normal)
    ExtrasButton.setBackgroundImage(backbuttonimage, for: .normal)
    }
    
//Save Button
    @IBAction func SaveBtn(_ sender: UIButton) {
        if(SaveButton.backgroundImage(for: .selected) != selectbuttonimage)
        {
            //turn off Canvas Menu
            if self.CanvasButton.backgroundImage(for: .normal) == selectbuttonimage
            {
            self.CanvasMenuDoneBtn(SaveButton)
            }
            
            SaveButton.setBackgroundImage(selectbuttonimage, for: .normal)
            
            // animates Canvas Menu
            self.view.addSubview(SaveMenu)
            SaveMenu.center = self.view.center
            SaveMenu.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            SaveMenu.alpha = 0
            
            UIView.animate(withDuration: 0.7, animations:
                {
                    self.SaveMenu.alpha = 1
                    self.SaveMenu.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            })
        }else
        {
            SaveButton.setBackgroundImage(backbuttonimage, for: .normal)
            self.SaveMenuCancel(SaveButton)
        }
    }
    @IBAction func SaveMenuCancel(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, delay: 0.05, animations: {self.SaveMenu.alpha = 0
            self.SaveMenu.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
            self.SaveButton.setBackgroundImage(self.backbuttonimage, for: .normal)}) { (AniFinished) in
                if(AniFinished){self.SaveMenu.removeFromSuperview()}
        }
    }
        
    @IBAction func SaveToFileBtn(_ sender: UIButton) {
        
        SaveSpinner.alpha = 0.85
        var NamedCanvas = SaveFileName.text
        
        //screen shot of the Canvas
        UIGraphicsBeginImageContext(CanvasView.frame.size)
        CanvasView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let SavedCanvasScreenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Convert SavedCanvasScreenShot to Compressed NSData - base64String
        let data = UIImageJPEGRepresentation(SavedCanvasScreenShot!,0.8)!
        let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        
        if(NamedCanvas != "")
        {
            //get firebase UID
            let user = FIRAuth.auth()?.currentUser
                if let user = user {
                    let uid = user.uid
                    let saveCanvas = dbRef.child("SavedCanvases").child(uid)
                    NamedCanvas = "\(SaveFileName.text!)"
                    
                    //send SavedFilename and SavedCanvasScreenshot to this userID Firebase
                    let CanvasSaved = SavedCanvas(canvasname: NamedCanvas!, savedimage: base64String, saved3dflowerssum: sumD3_Flowers, savedflatflowerssum: sumFlat_Flowers, savedleavessum: sumLeaves, savedextrassum: sumExtras)
                    
                    saveCanvas.setValue(CanvasSaved.toanyobject())
                    SaveSpinner.alpha = 0
                    
                    UIView.animate(withDuration: 1, animations: {
                        self.SaveFileName.text = "\(NamedCanvas!)"
                        self.SaveMenuCancel(self.SavetoFileButton)
                    })
                                    }
        }else{SaveFileName.placeholder = "You must supply a name"}
    }
    
    @IBAction func CanvasLoadBtn(_ sender: Any) {
        // get the image and values from Firebase
        self.CanvasSpinner.alpha = 0.85
        let user = FIRAuth.auth()!.currentUser!.uid
        let dataRef = dbRef.child("SavedCanvases").child(user)

        dataRef.queryOrdered(byChild: "\(user)").observeSingleEvent(of:
            .value, with: { (Snapshot) in
                let value = Snapshot.value as? NSDictionary
                let loadedencoded = value?["savedimage"] as! String!
                let loaded3dflowerssum = value?["saved3dflowerssum"] as! Double!
                let loadedflatflowersum = value?["savedflatflowerssum"] as! Double!
                let loadedleavessum = value?["savedleavessum"] as! Double!
                let loadedextrassum = value?["savedextrassum"] as! Double!
                
                self.CanvasSpinner.alpha = 0
                
                if(loadedencoded != nil)
                {
                //cant change the Canvas Colour if loaded image
                self.CanvasColourButton.isEnabled = false
                    
                //convert 64basestring image to uiimage
                let decodedData = NSData(base64Encoded: loadedencoded!, options: NSData.Base64DecodingOptions.init(rawValue: 0))
                let loadedimage = UIImage(data: decodedData as! Data)
                
                self.CanvasImage.image = loadedimage
                    
                self.CanvasMenuDoneBtn(self.CanvasLoadButton)
                    
                }else{
                        self.CanvasMenuDoneBtn(self.CanvasLoadButton)
                    let alert = UIAlertController(title: "Alert", message: "Error - no saved canvas found or loaded", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                    
                //add sums
                if (loadedflatflowersum != 0 && loadedflatflowersum != nil)
                {self.sumFlat_Flowers += loadedflatflowersum!}
                if (loadedleavessum != 0 && loadedleavessum != nil)
                {self.sumLeaves += loadedleavessum!}
                if (loaded3dflowerssum != 0 && loaded3dflowerssum != nil)
                {self.sumD3_Flowers += loaded3dflowerssum!}
                if (loadedextrassum != 0  && loadedextrassum != nil)
                {self.sumExtras += loadedextrassum!}
        })
    }
//Canvas Colour Menu
    @IBAction func CanvasColourBtn(_ sender: UIButton) {
        //turn off Canvas menu
        self.CanvasMenuDoneBtn(self.CanvasColourButton)
        
        //animate the CanvasColourPicker menu
        self.view.addSubview(CanvasColourPickerView)
        CanvasColourPickerView.center = self.view.center
        CanvasColourPickerView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        CanvasColourPickerView.alpha = 0
        
        UIView.animate(withDuration: 0.7, animations:
            {
                self.CanvasColourPickerView.alpha = 1
                self.CanvasColourPickerView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
    }
    
    @IBAction func CanvasColourCancelBtn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.05, animations: {self.CanvasColourPickerView.alpha = 0
            self.CanvasColourPickerView.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)})
        { (AniFinished) in
                if(AniFinished){self.CanvasColourPickerView.removeFromSuperview()}
        }
        //load canvas menu
        self.CanvasMenuBtn(self.CanvasColourCancelButton)
    }

    
//Canvas Menu and Buttons
    @IBAction func CanvasMenuBtn(_ sender: UIButton) {
       
        if(CanvasButton.backgroundImage(for: .selected) != selectbuttonimage)
        {
        //turn off Saved Menu
        if self.SaveButton.backgroundImage(for: .normal) == selectbuttonimage
        {
            self.SaveMenuCancel(CanvasButton)
        }

        CanvasButton.setBackgroundImage(selectbuttonimage, for: .normal)
        
        // animates Canvas Menu
        self.view.addSubview(CanvasMenu)
        CanvasMenu.center = self.view.center
        CanvasMenu.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        CanvasMenu.alpha = 0
        
        UIView.animate(withDuration: 0.7, animations:
            {
                self.CanvasMenu.alpha = 1
                self.CanvasMenu.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
        }else
        {
            CanvasButton.setBackgroundImage(backbuttonimage, for: .normal)
            CanvasMenuDoneBtn(CanvasMenuBtn: UIButton.self)
        }
    }
    
    @IBAction func CanvasMenuDoneBtn(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, delay: 0.05, animations: {self.CanvasMenu.alpha = 0
            self.CanvasMenu.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
            self.CanvasButton.setBackgroundImage(self.backbuttonimage, for: .normal)}) { (AniFinished) in
                if(AniFinished){self.CanvasMenu.removeFromSuperview()}
        }
    }
    
    @IBAction func CanvasMenuOrderBtn(_ sender: UIButton) {
        self.dismiss(animated: true) {}
        
        //screen shot of the Canvas to pass over to the Order
        UIGraphicsBeginImageContext(CanvasView.frame.size)
        CanvasView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let CanvasScreenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // UIImageWriteToSavedPhotosAlbum(CanvasScreenShot!, nil, nil, nil)
        
        delegate?.transferingtotals(Canvasphoto: CanvasScreenShot!, sumff: sumFlat_Flowers, suml: sumLeaves, sum3df: sumD3_Flowers, sume: sumExtras)
            }
    
    @IBAction func CanvasClearBtn(_ sender: UIButton) {
        //rests to original Canvas
        
        self.CanvasColourButton.isEnabled = true
        
        //set all vars to nil
        sumFlat_Flowers = 0.00
        sumLeaves = 0.00
        sumD3_Flowers = 0.00
        sumExtras = 0.00
        
        //clear images from the canvas
        for index in stride(from: newuiimageView.count - 1, through: 0, by: -1) {
            newuiimageView[index].removeFromSuperview()
        }
        newuiimageView.removeAll()
        
        //rest the canvas to default
        CanvasImage.image = UIImage(named: "Card_Purple.png")

    }
   
//Gesture Functions Double Tap Picker list, move and rotate Canvas UIImages
    func DT()
    {
     
        newuiimageView += [UIImageView(frame: CGRect(x: 0, y: CanvasView.frame.maxY - 130, width: 40, height: 40))]
        
        if Listclicktest == 1
        {
            newimage = Leaves[valueSelected]
            sumLeaves += Leaves_Costs[valueSelected]
        }
        else if Listclicktest == 2
        {
            newimage = D3_Flowers[valueSelected]
            sumD3_Flowers += D3_Flowers_Costs[valueSelected]
        }
        else if Listclicktest == 3
        {
            newimage = Extras[valueSelected]
            sumExtras += Extras_Costs[valueSelected]
        }
        else
        {
            newimage = Flat_Flowers[valueSelected]
            sumFlat_Flowers += Flat_Flowers_Costs[valueSelected]
        }
       
        countimages = newuiimageView.endIndex-1
        
        
        newuiimageView[countimages].image = newimage
        newuiimageView[countimages].tag = countimages
        
        CanvasView.addSubview(newuiimageView[countimages])
        
        let touchmoveUIimageview = UIPanGestureRecognizer.init(target: self, action: #selector(MoveCanvasUIImageView))
        let rotateUIimagview = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate))
        
        if(newuiimageView.count != 0)
        {
            newuiimageView[countimages].addGestureRecognizer(touchmoveUIimageview)
            newuiimageView[countimages].addGestureRecognizer(rotateUIimagview)
            newuiimageView[countimages].isUserInteractionEnabled = true
        }
    }
    
    func MoveCanvasUIImageView(_ touchmoveUIimageview: UIPanGestureRecognizer)
    {
    if touchmoveUIimageview.state == .began || touchmoveUIimageview.state == .changed{
        let translation = touchmoveUIimageview.translation(in: self.CanvasView)
        touchmoveUIimageview.view!.center = CGPoint(x: touchmoveUIimageview.view!.center.x + translation.x, y: touchmoveUIimageview.view!.center.y + translation.y)
        touchmoveUIimageview.setTranslation(CGPoint.zero, in: self.CanvasView)
        }
        
        let dtap = UITapGestureRecognizer.init(target: self, action: #selector(RemoveCanvasImage))
        dtap.numberOfTapsRequired = 2
        
        if newuiimageView.indices.contains(touchmoveUIimageview.view!.tag)
        {newuiimageView[touchmoveUIimageview.view!.tag].addGestureRecognizer(dtap)}
 
    }
    
    func RemoveCanvasImage(sender:UIGestureRecognizer)
    {
        if(newuiimageView.count != 0 && newuiimageView.indices.contains(sender.view!.tag))
        {
        let tag = sender.view!.tag
            if Leaves.contains(newuiimageView[tag].image!)
            {   let thisimage = newuiimageView[tag].image!
                let newtag = Leaves.index(of: thisimage)
                sumLeaves -= Leaves_Costs[newtag!]
            }
            else if D3_Flowers.contains(newuiimageView[tag].image!)
            {
                let thisimage = newuiimageView[tag].image!
                let newtag = D3_Flowers.index(of: thisimage)
                sumD3_Flowers -= D3_Flowers_Costs[newtag!]
            }
            else if Extras.contains(newuiimageView[tag].image!)
            {
                let thisimage = newuiimageView[tag].image!
                let newtag = Extras.index(of: thisimage)
                sumExtras -= Extras_Costs[newtag!]
            }
            else
            {
                let thisimage = newuiimageView[tag].image!
                let newtag = Flat_Flowers.index(of: thisimage)
                sumFlat_Flowers -= Flat_Flowers_Costs[newtag!]
            }
            newuiimageView[tag].removeFromSuperview()
            newuiimageView.remove(at: tag)

        }
    }
    
    func handleRotate(rotateUIimageview : UIRotationGestureRecognizer)
    {
        rotateUIimageview.view!.transform = CGAffineTransform(rotationAngle: rotateUIimageview.rotation)
        if(rotateUIimageview.rotation > 0)
        {rotateUIimageview.rotation += 0.0872665}
        if(rotateUIimageview.rotation < 0)
        {rotateUIimageview.rotation -= 0.0872665}
    }
    
//Logout of Firebase
    @IBAction func Logout(_ sender: UIBarButtonItem) {
       
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            GIDSignIn.sharedInstance().signOut()
        } catch let signOutError as NSError {
        print ("Error signing out: %@", signOutError)
        }
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
}
    


protocol transfertotalsdelegate
{
    func transferingtotals(Canvasphoto: UIImage, sumff:Double,suml:Double,sum3df:Double,sume:Double)
}

