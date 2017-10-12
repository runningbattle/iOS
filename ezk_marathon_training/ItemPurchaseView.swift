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
    var coin: Int = 100

    @IBAction func buyHealItem(_ sender: Any) {
        let alert : UIAlertController
        if coin < 10{
            alert = UIAlertController(title: "コインが足りません", message: "",
                                      preferredStyle: UIAlertControllerStyle.alert)
            } else if coin >= 10{
                healcount += 1
                coin = coin - 10
            }
    }
    
    @IBAction func buyAttackItem(_ sender: Any) {
        let alert : UIAlertController
        if coin < 10{
            alert = UIAlertController(title: "コインが足りません", message: "",
                                      preferredStyle: UIAlertControllerStyle.alert)
        } else if coin >= 10{
            attackcount += 1
            coin = coin - 10
        }
    }
    
    @IBAction func buyDefenseItem(_ sender: Any) {
        let alert : UIAlertController
        if coin < 10{
            alert = UIAlertController(title: "コインが足りません", message: "",
                                      preferredStyle: UIAlertControllerStyle.alert)
        } else if coin >= 10{
            defensecount += 1
            coin = coin - 10
        }

    }
    
    @IBAction func closeItem(_ sender: Any) {
        self.removeFromSuperview()
        
    }
}
