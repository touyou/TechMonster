//
//  ViewController.swift
//  TechMonster
//
//  Created by 藤井陽介 on 2016/02/02.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: NSTimer!
    var enemyTimer: NSTimer!
    
    var enemy: Enemy!
    var player: Player!
    
    let util:TechDraUtility = TechDraUtility()
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var attackButton: UIButton!
    
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var playerImageView: UIImageView!
    
    @IBOutlet var enemyHPBar: UIProgressView!
    @IBOutlet var playerHPBar: UIProgressView!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var playerNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        enemyHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        playerHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        initStatus()
        enemyTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(enemy.speed), target: self, selector: "enemyAttack", userInfo: nil, repeats: true)
        enemyTimer.fire()
    }
    
    // ステータスの初期化
    func initStatus() {
        enemy = Enemy()
        player = Player()
        enemyNameLabel.text = enemy.name
        playerNameLabel.text = player.name
        enemyImageView.image = enemy.image
        playerImageView.image = player.image
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        playerHPBar.progress = player.currentHP / player.currentHP
        
        cureHP()
    }
    
    override func viewDidAppear(animated: Bool) {
        util.playBGM("BGM_battle001")
    }
    
    // Player側がアタックする処理
    @IBAction func playerAttack() {
        TechDraUtility.damageAnimation(enemyImageView)
        util.playSE("SE_attack")
        enemy.currentHP = enemy.currentHP - player.attackPoint
        enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
        
        if enemy.currentHP <= 0.0 {
            finishBattle(enemyImageView, winPlayer: true)
        }
    }
    
    // 敵側の攻撃
    func enemyAttack() {
        TechDraUtility.damageAnimation(playerImageView)
        util.playSE("SE_attack")
        player.currentHP = player.currentHP - enemy.attackPoint
        playerHPBar.setProgress(player.currentHP / player.maxHP, animated: true)
        if player.currentHP <= 0.0 {
            finishBattle(playerImageView, winPlayer: false)
        }
    }
    
    // バトルが終了したとき
    func finishBattle(vanishImageView: UIImageView, winPlayer: Bool) {
        TechDraUtility.vanishAnimation(vanishImageView)
        util.stopBGM()
        timer.invalidate()
        enemyTimer.invalidate()
        
        var finishedMessage: String!
        
        if attackButton.hidden != true {
            attackButton.hidden = true
        }
        
        if winPlayer == true {
            util.playSE("SE_fanfare")
            finishedMessage = "プレイヤーの勝利！"
            let level: Int = NSUserDefaults.standardUserDefaults().integerForKey("level")
            NSUserDefaults.standardUserDefaults().setInteger(level + 1, forKey: "level")
        } else {
            util.playSE("SE_gameover")
            finishedMessage = "プレイヤーの敗北..."
        }
        
        let stamina: Float = NSUserDefaults.standardUserDefaults().floatForKey("stamina")
        NSUserDefaults.standardUserDefaults().setFloat(stamina - 15.0, forKey: "stamina")
        
        let alert = UIAlertController(title: "バトル終了！", message: finishedMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: Cure
    func cureHP() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateHPValue", userInfo: nil, repeats: true)
        timer.fire()
    }
    // 一定時間で敵味方ともに回復していくらしい
    func updateHPValue() {
        if enemy.currentHP < enemy.maxHP {
            enemy.currentHP = enemy.currentHP + enemy.defencePoint
            enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        }
        if player.currentHP < player.maxHP {
            player.currentHP = player.currentHP + player.defencePoint
            playerHPBar.progress = player.currentHP / player.maxHP
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

