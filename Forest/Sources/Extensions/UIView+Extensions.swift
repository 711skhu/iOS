//
//  UIView+Extension.swift
//  Forest
//
//  Created by wookeon on 26/03/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

    // UIView Extension
extension UIView {
    
    // Set Rounded View
    func makeRounded(cornerRadius : CGFloat?){
        if let cornerRadius_ = cornerRadius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
    
    // Set UIView's Shadow
    func dropShadow(color: UIColor, offSet: CGSize, opacity: Float, radius: CGFloat) {
        
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offSet
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    // Set UIView's Border
    func setBorder(borderColor : UIColor?, borderWidth : CGFloat?) {
        if let borderColor_ = borderColor {
            self.layer.borderColor = borderColor_.cgColor
        } else {
            self.layer.borderColor = UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0).cgColor
        }
        
        
        if let borderWidth_ = borderWidth {
            self.layer.borderWidth = borderWidth_
        } else {
            self.layer.borderWidth = 1.0
        }
    }
}
