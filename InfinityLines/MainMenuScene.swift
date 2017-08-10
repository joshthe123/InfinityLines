//
//  MainMenuScene.swift
//  InfinityLines
//
//  Created by iD Student on 8/10/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import Foundation
import SpriteKit
class MainMenuScene: SKScene {
    
    var infinityLabel = SKLabelNode(fontNamed: "Arial")
    var startButton = SKSpriteNode(imageNamed: "StartButton")
    var howButton = SKSpriteNode(imageNamed: "HowButton")
    var settingsButton = SKSpriteNode(imageNamed: "SettingsButton")
    var linesLabel = SKLabelNode(fontNamed: "Arial")
    
    
    
    
    
    override func didMove(to view: SKView) {
        view.backgroundColor = UIColor.black
        infinityLabel.position = CGPoint(x: size.width/2, y: size.height-100)
        infinityLabel.fontColor = UIColor.white
        infinityLabel.fontSize = 50
        infinityLabel.text = "INFINITY"
        
        startButton.position = CGPoint(x: size.width/2, y: size.height/2 + 125)
        howButton.position = CGPoint(x: size.width/2, y: size.height/2)
        settingsButton.position = CGPoint(x: size.width/2, y: size.height/2 - 125)
        
        linesLabel.position = CGPoint(x: size.width/2, y: 100)
        linesLabel.fontColor = UIColor.white
        linesLabel.fontSize = 50
        linesLabel.text = "LINES"
        
        addChild(infinityLabel)
        addChild(startButton)
        addChild(howButton)
        addChild(settingsButton)
        addChild(linesLabel)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let touchLocation = touch.location(in: self)
        
        if startButton.contains(touchLocation){
            let scene = GameScene(fileNamed: "GameScene")
            // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
            // Present the scene
            view?.presentScene(scene)
        }
        if howButton.contains(touchLocation){
            let scene = HowToPlayMenu(size: (view?.bounds.size)!)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view?.presentScene(scene)
        }

    }
}
