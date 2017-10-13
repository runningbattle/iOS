//
//  BattleViewController.swift
//  ezk_marathon_training
//
//  Created by Risa Ezoe on 2017/10/02.
//  Copyright © 2017年 Kazuki Kanamaru. All rights reserved.
//

import UIKit

enum BattleStatus{
    case stop
    case lose
    case win
}

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
    var hpTimer = Timer()
    var count: Float = 10
    var enemyMaxHp: Float = 50
    var enemyHp: Float = 50
    var youMaxHp: Float = 50
    var youHp: Float = 50
    var maxCount: Float = 10
    var itemPopUpView: ItemPopUpView? = nil

    
    override func loadView() {
        super.loadView()
        youHpGuage.transform = CGAffineTransform(scaleX:1.0, y:3.0)
        // 反時計回りに90度回転して表示する
        let sanbai = CGAffineTransform(scaleX:1.0, y:3.0)
        enemyHpGuage.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI)).concatenating(sanbai)
        enemyMaxHpLabel.text = String(format: "%.0f", enemyMaxHp)
        youMaxHpLabel.text = String(format: "%.0f", youMaxHp)
        enemyHpLabel.text = String(format: "%.0f", enemyMaxHp)
        youHpLabel.text = String(format: "%.0f", youMaxHp)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enemyHpGuage.progress = 1.0
        youHpGuage.progress = 1.0
        itemPopUpView = UINib(nibName: "View", bundle: nil).instantiate(withOwner: self,options: nil)[0] as? ItemPopUpView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guageInit()
        if count <= 0 {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
        hpTimer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(BattleViewController.youDamageHp(timer:)), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func tapedEnemyButton(_ sender: Any) {
        enemyHp -= 5
        enemyHpGuage.progress = enemyHp / enemyMaxHp
        
        //label表示
        enemyHpLabel.text = String(format: "%.0f", enemyHp)
        
        //勝ち
        if enemyHpGuage.progress == 0.0{
            battleAlert(.win)
        }
    }
    @IBAction func tappedStop(_ sender: Any) {
        battleAlert(.stop)
    }
    
    //item表示
    @IBAction func itemButton(_ sender: Any) {
        self.view.addSubview(itemPopUpView!)
    }
}


///MARK: - Private
extension BattleViewController{
    
    func youDamageHp(timer : Timer) {
        youHp -= 2
        youHpGuage.progress = youHp / youMaxHp
        
        //label表示
        youHpLabel.text = String(format: "%.0f", youHp)
        
        //負け
        if youHpGuage.progress == 0.0{
            battleAlert(.lose)
        }
    }
    
    func battleAlert(_ status : BattleStatus){
        hpTimer.invalidate()       //timer停止
        timer.invalidate()       //timer停止

        let alert : UIAlertController
        let alertTitle: String!
        let alertActionTitle: String!
        //再挑戦ボタン
        switch  status{
        case .lose:
            alertTitle = "ゲームオーバー"
            alertActionTitle = "再挑戦"
        case .win:
            alertTitle = "勝利"
            alertActionTitle = "次へ"
        case .stop:
            alertTitle = "一時停止"
            alertActionTitle = "再開"
        }
        
        alert = UIAlertController(title: alertTitle, message: "", preferredStyle:  UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: alertActionTitle, style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            self.customHandler(status)
        })
        alert.addAction(defaultAction)
        
        // 終了ボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "終了", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            //画面遷移
        })
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    fileprivate func customHandler(_ status: BattleStatus){
        switch status {
        case .win:
            self.guageInit()
            //item画面も閉じる
            self.itemPopUpView?.removeFromSuperview()
        case .lose:
            self.guageInit()
            //item画面も閉じる
            self.itemPopUpView?.removeFromSuperview()
        case .stop:
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
            self.hpTimer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(BattleViewController.youDamageHp(timer:)), userInfo: nil, repeats: true)
        }
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
        if count <= 0{
            timer.invalidate()    //タイマーを止めるコード
            battleAlert(.lose)
        }
    }

    //初期化
    func guageInit(){
        
        //ゲージの初期化
        self.enemyHpGuage.progress = self.enemyMaxHp
        self.youHpGuage.progress = self.youMaxHp
        self.enemyHp = self.enemyMaxHp
        self.youHp = self.youMaxHp
        
        //labelの初期化
        self.enemyHpLabel.text = String(format: "%.0f", self.enemyHp)
        self.youHpLabel.text = String(format: "%.0f", self.youHp)
        
        //timer初期化
        self.count = self.maxCount
        self.timerLabel.text = String(format: "%.0f", self.maxCount)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
        self.hpTimer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(BattleViewController.youDamageHp(timer:)), userInfo: nil, repeats: true)
    }
}
