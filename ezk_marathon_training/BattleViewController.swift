//
//  BattleViewController.swift
//  ezk_marathon_training
//
//  Created by Risa Ezoe on 2017/10/02.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

//    @IBOutlet weak var youHpView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var enemyHpGuage: UIProgressView!
    @IBOutlet weak var youHpGuage: UIProgressView!
    
    var timer = Timer()
    var hp_timer = Timer()
    var count : Float = 15
    var enemy_max_hp:Float = 50.0
    var enemy_hp:Float = 50.0
    var you_max_hp:Float = 50.0
    var you_hp:Float = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youHpGuage.transform = CGAffineTransform(scaleX:1.0, y:3.0)
        // 反時計回りに90度回転して表示する
        let sanbai = CGAffineTransform(scaleX:1.0, y:3.0)
        enemyHpGuage.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI)).concatenating(sanbai)
        
        onUpdate(timer: timer)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
        hp_timer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(BattleViewController.youDamageHp(timer:)), userInfo: nil, repeats: true)
        
        enemyHpGuage.progress = 1.0
        youHpGuage.progress = 1.0

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapedEnemyButton(_ sender: Any) {
        enemy_hp -= 1
        enemyHpGuage.progress = enemy_hp / enemy_max_hp
    }
    func youDamageHp(timer : Timer) {
        you_hp -= 2
        youHpGuage.progress = you_hp / you_max_hp

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
