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
    
    @IBOutlet weak var coin_label: UILabel!
    var coin: Int = 0
    var itemPurchaseView:ItemPurchaseView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemPurchaseView = UINib(nibName: "ItemPurchaseView", bundle: nil).instantiate(withOwner: self,options: nil)[0] as? ItemPurchaseView
        
        
    }
    @IBAction func itemButtonTapped(_ sender: Any) {
        self.view.addSubview(itemPurchaseView!)
    }
    
}
