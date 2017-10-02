//
//  BattleViewController.swift
//  ezk_marathon_training
//
//  Created by Risa Ezoe on 2017/10/02.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    @IBOutlet weak var enemyHpView: UIView!
    @IBOutlet weak var youHpView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    var count : Float = 15
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onUpdate(timer: timer)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension BattleViewController{
    
            // タイマー起動のための中身
        func onUpdate(timer : Timer){
            
            // カウントの増減を実施
            count -= 1
            
            // 桁数を指定するコード
            let str = String(format: "%.0f", count)
            
            // countLabelに表示するコード
            timerLabel.text = str
            
            
//            //countLabelが”0”になったらタイマーを止めてgameoverが表示されるようにする
//            if count == 0{
//                timer.invalidate()    //タイマーを止めるコード
//                gameOver.isHidden = false
//            }
            
        }

}
