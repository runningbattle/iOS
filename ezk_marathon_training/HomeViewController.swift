//
//  HomeViewController.swift
//  ezk_marathon_training
//
//  Created by Kazuki Kanamaru on 2017/10/06.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let balloon = BalloonView(frame: CGRectMake((view.bounds.size.width - 280) / 2, 100, 280, 100))
        balloon.backgroundColor = UIColor.whiteColor()
        view.addSubview(balloon)
    }
    
}
