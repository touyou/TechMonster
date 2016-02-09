//
//  Player.swift
//  TechDra
//
//  Created by Master on 2015/03/24.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

import UIKit

class Player: NSObject {
    
    var name: String!
    var maxHP: Float!
    var currentHP: Float!
    var attackPoint: Float!
    var defencePoint: Float!
    var speed: Float!
    var image: UIImage!
    
    override init() {
        super.init()
        
        name = "falcon"
        maxHP = 100
        currentHP = 100
        attackPoint = 60
        defencePoint = 2
        speed = 1.2
        image = UIImage(named: "falcon.png")
    }
    // 一応他の味方を増やしたい時用に追加
    func Player(name: String, maxHP: Float, currentHP: Float, attackPoint: Float, defencePoint: Float, speed: Float, image:UIImage) {
        self.name = name
        self.maxHP = maxHP
        self.currentHP = currentHP
        self.attackPoint = attackPoint
        self.defencePoint = defencePoint
        self.speed = speed
        self.image = image
    }

}
