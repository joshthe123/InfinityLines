//
//  SettingsMenu.swift
//  InfinityLines
//
//  Created by iD Student on 8/10/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import Foundation
import SpriteKit

class SettingsMenu {
    
    var easyButton = SKSpriteNode(imageNamed: "EasyButton")
    var mediumButton = SKSpriteNode(imageNamed: "MediumButton")
    var hardButton = SKSpriteNode(imageNamed: "HardButton")
    
    
    override func didMove(to view: SKView) {
        
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
