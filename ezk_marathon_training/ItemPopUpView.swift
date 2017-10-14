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

class ItemPopUpView :  UIView {
    
    @IBOutlet weak var healCountLabel: UILabel!
    @IBOutlet weak var attackCountLabel: UILabel!
    @IBOutlet weak var defenceCountLabel: UILabel!
    
    var healCount: Int = 5
    var attackCount: Int = 5
    var defenceCount: Int = 5
    var battleViewController: BattleViewController? = nil
    
    
    @IBAction func tapScreen(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    //heal
    @IBAction func healButton(_ sender: Any) {
        useItem(.heal)
        if healCount != 0{
            healCount -= 1
            let str = String(format: "%d", healCount)
            healCountLabel.text = str
            self.removeFromSuperview()
        }
    }
    //attack
    @IBAction func attackButton(_ sender: Any) {
        useItem(.attack)
        if attackCount != 0{
            attackCount -= 1
            let str = String(format: "%d", attackCount)
            attackCountLabel.text = str
            self.removeFromSuperview()
        }
    }
    //defence
    @IBAction func defenceButton(_ sender: Any) {
        useItem(.defence)
        if defenceCount != 0{
            defenceCount -= 1
            let str = String(format: "%d", defenceCount)
            defenceCountLabel.text = str
            self.removeFromSuperview()
        }
    }
    
    func useItem(_ status : ItemStatus){
        switch status{
        case .heal:
            battleViewController?.youHp += 20
        case .attack:
            battleViewController?.attackPoint *= 1.5
        case .defence:
            battleViewController?.defencePoint *= 1.5
        }
    }
    
}
