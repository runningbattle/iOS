//
//  AutoLayout.swift
//  ezk_marathon_training
//
//  Created by Risa Ezoe on 2017/10/13.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import Foundation
import UIKit

/// 制約(NSLayoutConstraint)を生成する
/// - parameter item: 制約を追加するオブジェクト
/// - parameter attr: 制約を追加するオブジェクトに与える属性
/// - parameter to: 制約の相手
/// - parameter attrTo: 制約相手に使用する属性
/// - parameter constant: 定数値
/// - parameter multiplier: 乗数値
/// - parameter relate: 計算式の関係性
/// - parameter priority: 制約の優先度
/// - returns: 制約(NSLayoutConstraint)オブジェクト
public func Constraint(item: AnyObject, _ attr: NSLayoutAttribute, to: AnyObject?, _ attrTo: NSLayoutAttribute, constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, relate: NSLayoutRelation = .equal, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
    let ret = NSLayoutConstraint(
        item:       item,
        attribute:  attr,
        relatedBy:  relate,
        toItem:     to,
        attribute:  attrTo,
        multiplier: multiplier,
        constant:   constant
    )
    ret.priority = priority
    return ret
}
