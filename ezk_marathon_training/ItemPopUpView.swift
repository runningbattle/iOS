//
//  ItemPopUpView.swift
//  ezk_marathon_training
//
//  Created by Risa Ezoe on 2017/10/10.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import UIKit

class ItemPopUpView :  UIView {
    
    @IBOutlet weak var healCount: UILabel!
    @IBOutlet weak var attackCount: UILabel!
    @IBOutlet weak var defenceCount: UILabel!
    
    var heal_count : Float = 5
    var attack_count : Float = 5
    var defence_count : Float = 5

    
    @IBAction func tapScreen(_ sender: Any) {
        self.removeFromSuperview()

    }
    
    //heal
    @IBAction func item1Button(_ sender: Any) {
        if heal_count != 0{
            heal_count -= 1
            let str = String(format: "%.0f", heal_count)
            healCount.text = str
            self.removeFromSuperview()
        }
    }
    //atack
    @IBAction func item2Button(_ sender: Any) {
        if attack_count != 0{
            attack_count -= 1
            let str = String(format: "%.0f", attack_count)
            attackCount.text = str
            self.removeFromSuperview()
        }
    }
    //defence
    @IBAction func item3Button(_ sender: Any) {
        if defence_count != 0{
            defence_count -= 1
            let str = String(format: "%.0f", defence_count)
            defenceCount.text = str
            self.removeFromSuperview()
        }
    }
    
}
