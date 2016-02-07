
//
//  LobbyViewController.swift
//  TechMonster
//
//  Created by 藤井陽介 on 2016/02/02.
//  Copyright © 2016年 touyou. All rights reserved.
//

import UIKit
import AVFoundation

class LobbyViewController: UIViewController {
    
    var stamina: Float = 0
    var staminaTimer: NSTimer!
    var util: TechDraUtility!
    var player: Player!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        player = Player()
        staminaBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        nameLabel.text = player.name
        
        util = TechDraUtility()
        cureStamina()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let level: Int = userDefaults.integerForKey("level")
        stamina = userDefaults.floatForKey("stamina")
        staminaBar.progress = stamina / 100
        levelLabel.text = String(format: "Lv. %d", level + 1)
        util.playBGM("lobby")
    }
    
    override func viewWillDisappear(animated: Bool) {
        util.stopBGM()
    }
    
    //MARK: Cure
    func cureStamina() {
        staminaTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: "updateStaminaValue", userInfo: nil, repeats: true)
        staminaTimer.fire()
    }
    
    func updateStaminaValue() {
        if stamina <= 100 {
            stamina = stamina + 1
            staminaBar.progress = stamina / 100
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonPushed(sender: UIButton) {
        if stamina >= 15 {
            self.performSegueWithIdentifier("toBattleView", sender: nil)
        } else {
            let alert: UIAlertController = UIAlertController(title: "スタミナが足りません!", message: "スタミナは15分に1/100回復します", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func reset() {
        NSUserDefaults.standardUserDefaults().setFloat(100.0, forKey: "stamina")
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "level")
        stamina = 100
        staminaBar.progress = stamina / 100
        levelLabel.text = String(format: "Lv. %d", 1)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
