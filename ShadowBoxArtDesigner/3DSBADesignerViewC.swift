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
    
    let Leaves:[UIImage] = [UIImage(named:"Flat_Leaf.png")!, UIImage(named:"Flat_SevenLeaf_Leaf.png")!, UIImage(named:"Flat_SevenLeaf_Leaf2.png")!,UIImage(named:"Flat_SingleLeaf_CentreCutout_Leaf.png")!, UIImage(named:"Flat_Small_Single_Leaf.png")!,UIImage(named:"Flat_Standard_Leaf.png")!, UIImage(named:"Single_Small_Pet_Leaf.png")!]
    
    let D3_Flowers: [UIImage] = [UIImage(named:"3D_Pet_Bud.png")!,UIImage(named:"3D_MultiLayered_Flower_Large.png")!,UIImage(named:"3D_FourLayered_Flower_Small.png")!, UIImage(named:"3D_ThreeLayered_Flower_Small.png")!]
    
    let Extras:[UIImage] = [UIImage(named:"Flat_LargeButterfly.png")!, UIImage(named:"Extras_CutOut_Flower.png")!, UIImage(named:"Extra_Pattern.png")!, UIImage(named:"Extras_Large_Feather.png")!, UIImage(named:"Extras_Smaller_Feather.png")!]

    //vars
    var Listclicktest = 0
    
    //let
    let backbuttonimage = UIImage(named:"ButtonBackground.png")!
    let selectbuttonimage = UIImage(named:"SelectedButton.png")!
    
    @IBOutlet weak var ImagePicker: AKPickerView!
    
    //Label outlets
    @IBOutlet weak var PickerLabel: UILabel!
    
    //button outlets ListButtons
    @IBOutlet weak var ListButton: UIButton!
    
    @IBOutlet weak var FlatFlowersButton: UIButton!
    @IBOutlet weak var D3FlowersButton: UIButton!
    @IBOutlet weak var LeavesButton: UIButton!
    @IBOutlet weak var ExtrasButton: UIButton!

    //Menu outlets
    @IBOutlet weak var ListMenu: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImagePicker.delegate = self
        ImagePicker.dataSource = self
        
        ImagePicker.layer.cornerRadius = 5
        ImagePicker.layer.shadowRadius = 2
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

}
