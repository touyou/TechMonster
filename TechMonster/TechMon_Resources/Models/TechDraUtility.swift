//
//  TechDraUtility.swift
//  TechDra
//
//  Created by Master on 2015/03/23.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

import UIKit
import AVFoundation

class TechDraUtility: NSObject, AVAudioPlayerDelegate {
    
    var BGM_audioPlayer: AVAudioPlayer!
    var SE_audioPlayer: AVAudioPlayer!
    
    override init() {
        super.init()
        
        BGM_audioPlayer = AVAudioPlayer()
    }
    
    //MARK: Animations
    class func damageAnimation(imageView: UIImageView) {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.02
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(imageView.center.x - 5, imageView.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(imageView.center.x + 5, imageView.center.y))
        imageView.layer.addAnimation(animation, forKey: "position")
        
    }
    
    /* invalid v1.0
    class func attackAnimation(imageView: UIImageView) {
        
    }
    */
    
    class func vanishAnimation(imageView: UIImageView) {
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            imageView.alpha = 0.0
            }, completion: nil)
    }

    
    // エラーが発生していたのでサウンド再生部分はClapで使われていた書き方を流用
    //MARK: Sound Effects
    func playSE(fileName: String) {
        
        //AVAudioPlayer
        let soundFilePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")!
        let fileURL: NSURL = NSURL(fileURLWithPath: soundFilePath)
        /*
        //TODO: fix unwrapping error
        var error: NSError? = nil
        NSLog("%@", error!)
        */
        do {
            SE_audioPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
        } catch {
            print("音楽ファイルを読み込めませんでした。")
        }
        SE_audioPlayer.prepareToPlay()
        if SE_audioPlayer.playing == true {
            SE_audioPlayer.currentTime = 0
        }
        SE_audioPlayer.play()
        
        /*
        // AudioToolBox
        let soundURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: "mp3")
        var mySound: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL, &mySound)
        AudioServicesPlaySystemSound(mySound);
        */
    }
    
    func playBGM(fileName: String) {

        let soundFilePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")!
        let fileURL : NSURL = NSURL(fileURLWithPath: soundFilePath)
        /*
        //TODO: fix unwrapping error
        var error: NSError? = nil
        NSLog("%@", error!)
        */
        do {
            BGM_audioPlayer = try AVAudioPlayer(contentsOfURL: fileURL)
        } catch {
            print("音楽ファイルを読み込めませんでした。")
        }
        BGM_audioPlayer.numberOfLoops = -1
        BGM_audioPlayer.delegate = self
        BGM_audioPlayer.prepareToPlay()
        if BGM_audioPlayer.playing == true {
            BGM_audioPlayer.currentTime = 0
        }
        
        BGM_audioPlayer.play()
    }
    
    func stopBGM() {
        BGM_audioPlayer.stop()
    }
    
    /*func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        if flag {
            
        }
    }*/
}
