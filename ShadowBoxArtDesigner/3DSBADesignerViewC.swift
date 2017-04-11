//
//  3DSBADesignerViewC.swift
//  ShadowBoxArtDesigner
//
//  Created by Michael Harvey on 31/3/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class _DSBADesignerViewC: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate  {
    
    let Flat_Flowers: [UIImage] = [UIImage(named:"Flat_SingleLayer_VerySmall_Crystal_Bud.png")!, UIImage(named:"Flat_ThreeLayers.png")!, UIImage(named:"Flat_TwoLayeredBud.png")!, UIImage(named:"Flat_TwoLeaf_Bud.png")!, UIImage(named:"Flat_SingleLayer_Small_Flower.png")!,
                                   UIImage(named:"Flat_ThreeLayers_vinedBud.png")!, UIImage(named:"Flat_ThreeLayer_Small_Flower.png")!, UIImage(named:"Flat_SixStar_Large_Flower.png")!, UIImage(named:"Flat_SixStar_Small_Flower.png")!]
    let Flat_Flowers_Costs = [0.10,0.20,0.20,0.30,0.10,0.30,0.40,0.20,0.10]
    
    let Leaves:[UIImage] = [UIImage(named:"Flat_Leaf.png")!, UIImage(named:"Flat_SevenLeaf_Leaf.png")!, UIImage(named:"Flat_SevenLeaf_Leaf2.png")!,UIImage(named:"Flat_SingleLeaf_CentreCutout_Leaf.png")!, UIImage(named:"Flat_Small_Single_Leaf.png")!,UIImage(named:"Flat_Standard_Leaf.png")!, UIImage(named:"Single_Small_Pet_Leaf.png")!]
    let Leaves_Costs = [0.10,0.10,0.10,0.15,0.10,0.10,0.05]
    
    let D3_Flowers: [UIImage] = [UIImage(named:"3D_Pet_Bud.png")!,UIImage(named:"3D_MultiLayered_Flower_Large.png")!,UIImage(named:"3D_FourLayered_Flower_Small.png")!, UIImage(named:"3D_ThreeLayered_Flower_Small.png")!]
    let D3_Flowers_Costs = [0.60,0.50,0.50,0.60]
    
    let Extras:[UIImage] = [UIImage(named:"Flat_LargeButterfly.png")!, UIImage(named:"Extras_CutOut_Flower.png")!, UIImage(named:"Extra_Pattern.png")!, UIImage(named:"Extras_Large_Feather.png")!, UIImage(named:"Extras_Smaller_Feather.png")!]
    let Extras_Costs = [0.45,0.30,0.40,0.30,0.25]
    
    var storeCanvasImages = [UIImage]()

    //vars
    var Listclicktest = 0
    var countimages = 0
    var valueSelected = 0
    
    
    var sumFlat_Flowers = 0.00
    var sumLeaves = 0.00
    var sumD3_Flowers = 0.00
    var sumExtras = 0.00
    var totalsum = 0.00
    
    var newimage = UIImage()
    var newuiimageView: [UIImageView] = []
    
    
    //let
    let backbuttonimage = UIImage(named:"ButtonBackground.png")!
    let selectbuttonimage = UIImage(named:"SelectedButton.png")!
    
    @IBOutlet weak var ImagePicker: AKPickerView!
    
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var CanvasView: UIView!
    
    //Label outlets
    @IBOutlet weak var PickerLabel: UILabel!
    
    //button outlets ListButtons
    @IBOutlet weak var ListButton: UIButton!
    
    @IBOutlet weak var FlatFlowersButton: UIButton!
    @IBOutlet weak var D3FlowersButton: UIButton!
    @IBOutlet weak var LeavesButton: UIButton!
    @IBOutlet weak var ExtrasButton: UIButton!
    
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
        
    }
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

//List Menu and its buttons
    @IBAction func ListBtn(_ sender: UIButton) {
        if(ListButton.backgroundImage(for: .selected) != backbuttonimage)
        {ListButton.setBackgroundImage(backbuttonimage, for: .normal)
        ListMenu.alpha = 0}
        else{ListButton.setBackgroundImage(selectbuttonimage, for: .normal)
        ListMenu.alpha = 1}}
    
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

        print("Countimages after delete \(countimages)")
        print("SumLeaves = \(sumLeaves)")
        print("Sum 3D flowers = \(sumD3_Flowers)")
        print("Sum Extras = \(sumExtras)")
        print("Sum flat Flowers = \(sumFlat_Flowers)")
            
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

}
