//
//  GameScene.swift
//  InfinityLines
//
//  Created by iD Student on 8/4/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var map = [[Int]]()
    let cellSize : Int = 5
    var direction = 0
    struct CellValue {
        static let empty = 0
        static let bod = 1
        static let laser = 2
        static let power = 3
    }
    struct Directions {
        static let still = 0
        static let up = 1
        static let down = 2
        static let left = 3
        static let right = 4
    }
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        map = Array(repeating: Array(repeating: 0, count: Int(size.height)), count: Int(size.width))
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))

    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        print("up")

    }
    func swipedDown(sender:UISwipeGestureRecognizer){
        print("Down")
        
    }
    func swipedLeft(sender:UISwipeGestureRecognizer){
        print("Left")

    }
    func swipedRight(sender:UISwipeGestureRecognizer){
        print("Right")
    
    }

    func touchDown(atPoint pos : CGPoint) {
 
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    func takeStep() {
      
        
    }
}
