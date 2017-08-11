//
//  HowToPlayMenu.swift
//  InfinityLines
//
//  Created by iD Student on 8/10/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class HowToPlayMenu: SKScene {
    
    var backButton  = SKSpriteNode(imageNamed: "BackButton")
    var instructions : UITextView?
    var howToLabel = SKLabelNode(fontNamed: "Arial")
    override func didMove(to view: SKView) {
        view.backgroundColor = UIColor.black
        self.backgroundColor = UIColor.black
        backButton.position = CGPoint(x: 35, y: size.height - 35)
        howToLabel.position = CGPoint(x: size.width/2, y: 75)
        howToLabel.fontColor = UIColor.white
        howToLabel.fontSize = 35
        addChild(backButton)
        addChild(howToLabel)
        instructions = UITextView(frame: CGRect(x: 25, y: 200, width: size.width-50, height: size.height-200))
        instructions?.isHidden = false
        instructions?.text = "The goal of the game is to survive as long as you can. You play as a red line and you can not hit your own line or you will explode and you can not hit the lines that go either up, down, left, or right. Make sure you don't accidentally go backwards or you will explode. Your score will increase every 0.3 seconds and depending on the selected difficulty it will go up either by 1, 2, 3, or 4. To play on easy mode, at the beginning swipe up. To play on medium mode swipe down. Swipe left to play on hard and swipe right to play on extreme."
        instructions?.isEditable = false
        instructions?.backgroundColor = UIColor.black
        instructions?.textColor = UIColor.white
        instructions?.font = UIFont(name: "Arial", size: 20)

        self.view?.addSubview(instructions!)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let touchLocation = touch.location(in: self)
        
        if backButton.contains(touchLocation){
            instructions?.isHidden = true
            let scene = MainMenuScene(size: (view?.bounds.size)!)
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view?.presentScene(scene)
        }
    }

    
}
