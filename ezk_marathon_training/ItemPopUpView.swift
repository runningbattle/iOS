//
//  ItemPopUpView.swift
//  ezk_marathon_training
//
//  Created by Risa Ezoe on 2017/10/10.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import UIKit


enum ItemStatus{
    case heal
    case attack
    case defence
}

protocol ItemPopUpViewDelegate {
    func tapped(_ status: ItemStatus)
}

class ItemPopUpView :  UIView {
    
    @IBOutlet weak var healCountLabel: UILabel!
    @IBOutlet weak var attackCountLabel: UILabel!
    @IBOutlet weak var defenceCountLabel: UILabel!
    
    var healCount: Int = 5
    var attackCount: Int = 5
    var defenceCount: Int = 5
    var battleViewController: BattleViewController? = nil
    var delegate: ItemPopUpViewDelegate?
        
    @IBAction func tapScreen(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    //heal
    @IBAction func healButton(_ sender: Any) {
        //useItem(.heal)
        if healCount != 0{
            healCount -= 1
            let str = String(format: "%d", healCount)
            healCountLabel.text = str
            self.removeFromSuperview()
        }
        self.delegate?.tapped(.heal)
    }
    
    //attack
    @IBAction func attackButton(_ sender: Any) {
        if attackCount != 0{
            attackCount -= 1
            let str = String(format: "%d", attackCount)
            attackCountLabel.text = str
            self.removeFromSuperview()
        }
        self.delegate?.tapped(.attack)
    }
    
    //defence
    @IBAction func defenceButton(_ sender: Any) {
        if defenceCount != 0{
            defenceCount -= 1
            let str = String(format: "%d", defenceCount)
            defenceCountLabel.text = str
            self.removeFromSuperview()
        }
        self.delegate?.tapped(.defence)
    }
}
