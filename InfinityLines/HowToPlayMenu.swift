//
//  HowToPlayMenu.swift
//  InfinityLines
//
//  Created by iD Student on 8/10/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import Foundation
import SpriteKit

class HowToPlayMenu: SKScene {
    
    var backButton  = SKSpriteNode(imageNamed: "BackButton")
    
    var howToLabel = SKLabelNode(fontNamed: "Arial")
    
    override func didMove(to view: SKView) {
        view.backgroundColor = UIColor.black

        backButton.position = CGPoint(x: 35, y: size.height - 35)
        addChild(backButton)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let touchLocation = touch.location(in: self)
        
        if backButton.contains(touchLocation){
            let scene = MainMenuScene(size: (view?.bounds.size)!)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view?.presentScene(scene)
        }
    }

    
}
