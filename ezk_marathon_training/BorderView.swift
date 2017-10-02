//
//  BorderView.swift
//  ezk_marathon_training
//
//  Created by Risa Ezoe on 2017/10/02.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import Foundation
import UIKit
//
//  UIView.swift
//  PDFramework
//
//  Copyright © 2016年 P&D All rights reserved.
//

extension UIView {
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            return (layer.borderColor != nil) ? UIColor(cgColor: layer.borderColor!) : UIColor.white
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    /**
     部分的に角丸にする
     
     - parameter roundingCorners: ([UIRectCorner])  角丸にしたい部分を配列で指定する
     - parameter radius: (CGFloat)   角丸の半径を指定
     */
    public func cornerRadius(roundingCorners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: roundingCorners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        
        self.layer.mask = maskLayer
    }
}

@IBDesignable open class BorderView: UIView{

}

