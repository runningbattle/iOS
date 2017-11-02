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
    @IBOutlet weak var distanceLabel: UILabel!
    var coin: Int = 0
    var itemPurchaseView:ItemPurchaseView? = nil
    var level: Int = 0
    var last: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemPurchaseView = UINib(nibName: "ItemPurchaseView", bundle: nil).instantiate(withOwner: self,options: nil)[0] as? ItemPurchaseView
        
        let hk =  HealthKitAccess()
        hk.recentDistance(findDate: Date()) { (distance, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.distanceLabel.text = "\(distance/1000)"
                }
                
            }
        }
        
        let level = 
    }
    @IBAction func itemButtonTapped(_ sender: Any) {
        self.view.addSubview(itemPurchaseView!)
    }
    
}
