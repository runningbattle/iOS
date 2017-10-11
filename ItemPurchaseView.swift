//
//  ItemPurchaseView.swift
//  ezk_marathon_training
//
//  Created by Kazuki Kanamaru on 2017/10/11.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import UIKit

class ItemPurchaseView: UIView {
    
    @IBOutlet weak var heal_count_label: UILabel!
    @IBOutlet weak var attack_count_label: UILabel!
    @IBOutlet weak var defense_count_label: UILabel!
    
    var healcount: Int = 5
    var attackcount: Int = 5
    var defensecount: Int = 5

    
    @IBAction func useHealItem(_ sender: Any) {
//        if(Int <= 100){
//            print("コインが足りません")
//        }
        
    }
    
    @IBAction func useAttackItem(_ sender: Any) {
      healcount -= 1
    }
    
    @IBAction func useDefenseItem(_ sender: Any) {
      attackcount -= 1
    }
    
    @IBAction func closeItem(_ sender: Any) {
      defensecount -= 1
        self.removeFromSuperview()
        
    }
}
