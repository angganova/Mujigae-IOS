//
//  ItemGrid.swift
//  TestApp
//
//  Created by Ania on 15/04/19.
//  Copyright © 2019 FullStackDiv. All rights reserved.
//


import UIKit

class ItemGrid: UICollectionViewCell {
   
    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var tv: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    
    var grayCG : CGColor? = nil
    var grayUI : UIColor? = nil
    
    var redCG : CGColor? = nil
    var redUI : UIColor? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewBackground.layer.cornerRadius = 15
        viewBackground.layer.borderWidth = 2
    }
    
    func setColor(selectedColor: UIColor, unSelectedColor: UIColor){
        self.grayUI = unSelectedColor
        self.grayCG = unSelectedColor.cgColor
        
        self.redUI = selectedColor
        self.redCG = selectedColor.cgColor
    }
    
    func displaySelected(label: String){
        tv.text = label
        tv.textColor = redUI
        
        viewBackground.layer.borderColor = redCG
    }
    
    func displayUnselected(label: String){
        tv.text = label
        tv.textColor = grayUI
        
        viewBackground.layer.borderColor = grayCG
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

