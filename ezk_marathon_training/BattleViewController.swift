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

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var enemyHpGuage: UIProgressView!
    @IBOutlet weak var youHpGuage: UIProgressView!
    @IBOutlet weak var enemyMaxHpLabel: UILabel!
    @IBOutlet weak var youMaxHpLabel: UILabel!
    @IBOutlet weak var enemyHpLabel: UILabel!
    @IBOutlet weak var youHpLabel: UILabel!
    
    var timer = Timer()
    var hpTimer = Timer()
    var count: Int = 30
    var enemyMaxHp: Float = 50
    var enemyHp: Float = 50
    var youMaxHp: Float = 300
    var youHp: Float = 50
    var maxCount: Int = 30
    var attackPoint: Float = 7
    var defencePoint: Float = 15
    var itemPopUpView: ItemPopUpView?

    
    override func loadView() {
        super.loadView()
        youHpGuage.transform = CGAffineTransform(scaleX:1.0, y:3.0)
        // 反時計回りに90度回転して表示する
        let triple = CGAffineTransform(scaleX:1.0, y:3.0)
        enemyHpGuage.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI)).concatenating(triple)
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
        guageInit()
        if count <= 0 {
            timer.invalidate()
        }
        itemPopUpView?.delegate = self
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timerLabel.text = String(format: "%d", maxCount)
    }
    
    
    @IBAction func tapedEnemyButton(_ sender: Any) {
        enemyHp -= attackPoint
        enemyHpGuage.progress = enemyHp / enemyMaxHp
        if enemyHp <= 0{
            enemyHp = 0
        }
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
    
    // タイマー起動のための中身
    func onUpdate(timer : Timer){
        count -= 1
        let str = String(count)
        if count <= 0{
            //タイマーを止めるコード
            timer.invalidate()
            battleAlert(.lose)
        }
        timerLabel.text = str
    }
    
    func youDamageHp(timer : Timer) {
        youHp -= defencePoint
        youHpGuage.progress = youHp / youMaxHp
        if youHp <= 0{
            youHp = 0
        }
        youHpLabel.text = String(format: "%.0f", youHp)
        //負け
        if youHpGuage.progress == 0.0{
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
        self.timerLabel.text = String(format: "%d", self.maxCount)
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
        self.hpTimer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(BattleViewController.youDamageHp(timer:)), userInfo: nil, repeats: true)
    }
}


///MARK - FilePrivates
extension BattleViewController{
    
    fileprivate func customHandler(_ status: BattleStatus){
        switch status {
        case .win:
            self.guageInit()
            //item画面も閉じる
            self.itemPopUpView?.removeFromSuperview()
        case .lose:
            self.guageInit()
            self.itemPopUpView?.removeFromSuperview()
        case .stop:
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BattleViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
            self.hpTimer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(BattleViewController.youDamageHp(timer:)), userInfo: nil, repeats: true)
        }
    }
    
    func battleAlert(_ status : BattleStatus){
        //timer停止
        hpTimer.invalidate()
        timer.invalidate()
        
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
            (action: UIAlertAction!) -> Void in
            //画面遷移
        })
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension BattleViewController: ItemPopUpViewDelegate{
    
    func tapped(_ status: ItemStatus) {
        switch status{
         case .heal:
            self.youHp += 20
            self.youHpLabel.text = String(format: "%.0f", self.youHp)
         case .attack:
            self.attackPoint *= 1.5
         case .defence:
            self.defencePoint *= 1.5
         }
    }
}
