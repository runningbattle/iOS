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
    @IBOutlet weak var enemyMaxHpLabel: UILabel!
    @IBOutlet weak var youMaxHpLabel: UILabel!
    @IBOutlet weak var enemyHpLabel: UILabel!
    @IBOutlet weak var youHpLabel: UILabel!
    
    var timer = Timer()
    var hp_timer = Timer()
    var count : Float = 10
    var enemy_max_hp:Float = 50
    var enemy_hp:Float = 50
    var you_max_hp:Float = 50
    var you_hp:Float = 50
    var max_count : Float = 10
    var itemPopUpView:ItemPopUpView? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youHpGuage.transform = CGAffineTransform(scaleX:1.0, y:3.0)
        // 反時計回りに90度回転して表示する
        let sanbai = CGAffineTransform(scaleX:1.0, y:3.0)
        enemyHpGuage.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI)).concatenating(sanbai)
        
//        onUpdate(timer: timer)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
        hp_timer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(BattleViewController.youDamageHp(timer:)), userInfo: nil, repeats: true)
        
        enemyHpGuage.progress = 1.0
        youHpGuage.progress = 1.0
        
        let enemy_max_str = String(format: "%.0f", enemy_max_hp)
        enemyMaxHpLabel.text = enemy_max_str
        let you_max_str = String(format: "%.0f", you_max_hp)
        youMaxHpLabel.text = you_max_str
        let enemy_str = String(format: "%.0f", enemy_max_hp)
        enemyHpLabel.text = enemy_str
        let you_str = String(format: "%.0f", you_max_hp)
        youHpLabel.text = you_str

        itemPopUpView = UINib(nibName: "View", bundle: nil).instantiate(withOwner: self,options: nil)[0] as? ItemPopUpView
        
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapedEnemyButton(_ sender: Any) {
        enemy_hp -= 5
        enemyHpGuage.progress = enemy_hp / enemy_max_hp
        
        //label表示
        let str = String(format: "%.0f", enemy_hp)
        enemyHpLabel.text = str
        
        //勝ち
        if enemyHpGuage.progress == 0.0{
            battleAlert("win")
        }
    }
    @IBAction func tappedStop(_ sender: Any) {
        battleAlert("pause")
    }
    
    //item表示
    @IBAction func itemButton(_ sender: Any) {
        self.view.addSubview(itemPopUpView!)
    }
    
    
    func youDamageHp(timer : Timer) {
        you_hp -= 2
        youHpGuage.progress = you_hp / you_max_hp
        
        //label表示
        let str = String(format: "%.0f", you_hp)
        youHpLabel.text = str

        
        //負け
        if youHpGuage.progress == 0.0{
            battleAlert("lose")
        }

    }
    func battleAlert(_ judge : String){
        hp_timer.invalidate()       //timer停止
        timer.invalidate()       //timer停止

        let alert : UIAlertController
        //再挑戦ボタン
        if judge == "lose"{
            alert = UIAlertController(title: "ゲームオーバー", message: "", preferredStyle:  UIAlertControllerStyle.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "再挑戦", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("再挑戦")
                self.guageInit()
                //item画面も閉じる
                self.itemPopUpView?.removeFromSuperview()
            })
            alert.addAction(defaultAction)

        } else if judge == "win"{
            alert = UIAlertController(title: "勝利", message: "", preferredStyle:  UIAlertControllerStyle.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "次へ", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("次へ")
                self.guageInit()
                //item画面も閉じる
                self.itemPopUpView?.removeFromSuperview()

            })
            alert.addAction(defaultAction)
            
        }else{
            alert = UIAlertController(title: "一時停止", message: "", preferredStyle:  UIAlertControllerStyle.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "再開", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("再開")
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
                self.hp_timer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(BattleViewController.youDamageHp(timer:)), userInfo: nil, repeats: true)
            })
            alert.addAction(defaultAction)
        }
        
        // 終了ボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "終了", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("終了")
            
        })
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)

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
        if count == 0{
            timer.invalidate()    //タイマーを止めるコード
            battleAlert("lose")
        }
    }

    //初期化
    func guageInit(){
        //ゲージの初期化
        self.enemyHpGuage.progress = self.enemy_max_hp
        self.youHpGuage.progress = self.you_max_hp
        self.enemy_hp = self.enemy_max_hp
        self.you_hp = self.you_max_hp
        
        //labelの初期化
        let enemy_str = String(format: "%.0f", self.enemy_hp)
        self.enemyHpLabel.text = enemy_str
        let you_str = String(format: "%.0f", self.you_hp)
        self.youHpLabel.text = you_str
        
        //timer初期化
        self.count = self.max_count
        let str = String(format: "%.0f", self.max_count)
        
        self.timerLabel.text = str
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
        self.hp_timer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(BattleViewController.youDamageHp(timer:)), userInfo: nil, repeats: true)
    }
}
