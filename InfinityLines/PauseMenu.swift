//
//  PauseMenu.swift
//  InfinityLines
//
//  Created by iD Student on 8/10/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import Foundation
import SpriteKit

class PauseMenu: SKScene{
    
    var restartButton = SKSpriteNode(imageNamed: "RestartButton")
    var mainMenuButton = SKSpriteNode(imageNamed: "MainMenuButton")
    
    
    
    override func didMove(to view: SKView) {
        restartButton.position = CGPoint(x: size.width/2, y: size.height/2 + 100)
        mainMenuButton.position = CGPoint(x: size.width/2, y: size.height/2 - 100)

        addChild(restartButton)
        addChild(mainMenuButton)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let touchLocation = touch.location(in: self)
        if restartButton.contains(touchLocation){
            let scene = GameScene(fileNamed: "GameScene")
            // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
            // Present the scene
            view?.presentScene(scene)
        }
        if mainMenuButton.contains(touchLocation){
            let scene = MainMenuScene(size: (view?.bounds.size)!)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view?.presentScene(scene)
        }

    }

}
