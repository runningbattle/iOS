//
//  ItemView.swift
//  ezk_marathon_training
//
//  Created by Kazuki Kanamaru on 2017/10/06.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import Foundation
import UIKit

class BalloonView: UIView {
    
    let triangleSideLength: CGFloat = 20
    let triangleHeight: CGFloat = 17.3
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor)
        contextBalloonPath(context!, rect: rect)
    }
    
    func contextBalloonPath(context: CGContextRef, rect: CGRect) {
        let triangleRightCorner = (x: (rect.size.width + triangleSideLength) / 2, y: CGRectGetMaxY(rect) - triangleHeight)
        let triangleBottomCorner = (x: rect.size.width / 2, y: CGRectGetMaxY(rect))
        let triangleLeftCorner = (x: (rect.size.width - triangleSideLength) / 2, y: CGRectGetMaxY(rect) - triangleHeight)
        
        // 塗りつぶし
        CGContextAddRect(context, CGRectMake(0, 0, 280, rect.size.height - triangleHeight))
        CGContextFillPath(context)
        CGContextMoveToPoint(context, triangleLeftCorner.x, triangleLeftCorner.y)
        CGContextAddLineToPoint(context, triangleBottomCorner.x, triangleBottomCorner.y)
        CGContextAddLineToPoint(context, triangleRightCorner.x, triangleRightCorner.y)
        CGContextFillPath(context)
    }
    
}
