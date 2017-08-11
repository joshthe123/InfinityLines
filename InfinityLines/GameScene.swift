//
//  GameScene.swift
//  InfinityLines
//
//  Created by iD Student on 8/4/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import SpriteKit
import GameplayKit


struct CellValue {
    static let empty = 0
    static let body = 1
    static let laser = 2
    static let wall = 3
    
}

struct Directions {
    static let still = 0
    static let up = 1
    static let down = 2
    static let left = 3
    static let right = 4
}

class GameScene: SKScene {
    var difficulty = 0
    var map = [[Int]]()
    let cellSize : CGFloat = 10
    var direction = 0
    var currentX : Int = 0
    var currentY : Int = 0
    var spriteMap = [[SKSpriteNode]]()
    var laserMap = [[Int]]()
    var touchToStartLabel = SKLabelNode()
    var laserArray = [Laser]()
    var bodyArray = [CGPoint]()
    let laserLength = 50
    var score : Int = 0
    var scoreLabel = SKLabelNode(fontNamed: "Arial")
    var pauseButton = SKSpriteNode(imageNamed: "PauseButton")
    override func didMove(to view: SKView) {
         self.backgroundColor = UIColor.black
        // Get label node from scene and store it for use later
        map = Array(repeating: Array(repeating: 0, count: Int(size.height/cellSize)), count: Int(size.width/cellSize))
        laserMap = Array(repeating: Array(repeating: 0, count: Int(size.height/cellSize)), count: Int(size.width/cellSize))
        currentX = Int(size.width/cellSize/2)
        currentY = Int(size.height/cellSize/2)
        bodyArray.append(CGPoint(x: currentX, y: currentY))
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        
        touchToStartLabel.fontSize = 50
        touchToStartLabel.fontName = "Arial"
        touchToStartLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        touchToStartLabel.text = "Swipe any direction to start"
        initializeMap()
        updateMapUI()
        pauseButton.position = CGPoint(x: size.width - 35, y: size.height - 35)
        addChild(touchToStartLabel)
        addChild(scoreLabel)
        addChild(pauseButton)
        swipeUp.direction = .up
        swipeDown.direction = .down
        swipeLeft.direction = .left
        swipeRight.direction = .right
        view.backgroundColor = UIColor.black
        view.addGestureRecognizer(swipeUp)
        
        view.addGestureRecognizer(swipeDown)

        view.addGestureRecognizer(swipeLeft)

        view.addGestureRecognizer(swipeRight)
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(takeStep),SKAction.run(updateMapUI), SKAction.wait(forDuration: 0.05)])), withKey: "GameLoop")
           }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        //print("up")
        if direction == Directions.still{
            touchToStartLabel.removeFromParent()
            difficulty = 1
            run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addLaser),SKAction.wait(forDuration: 5)])))
            run(SKAction.repeatForever(SKAction.sequence([SKAction.run(updateScore), SKAction.wait(forDuration: 0.3)])), withKey: "ScoreLoop")

        }
        direction = Directions.up
        
    }
    func swipedDown(sender:UISwipeGestureRecognizer){
        //print("Down")
        if direction == Directions.still{
            touchToStartLabel.removeFromParent()
            difficulty = 2
            run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addLaser),SKAction.wait(forDuration: 2.5)])))
            run(SKAction.repeatForever(SKAction.sequence([SKAction.run(updateScore), SKAction.wait(forDuration: 0.3)])), withKey: "ScoreLoop" )

        }
        direction = Directions.down
    }
    func swipedLeft(sender:UISwipeGestureRecognizer){
        //print("Left")
        if direction == Directions.still{
            difficulty = 3
            touchToStartLabel.removeFromParent()
            run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addLaser),SKAction.wait(forDuration: 1)])))
            run(SKAction.repeatForever(SKAction.sequence([SKAction.run(updateScore), SKAction.wait(forDuration: 0.3)])), withKey: "ScoreLoop")

        }
        direction = Directions.left
    }
    func swipedRight(sender:UISwipeGestureRecognizer){
        //print("Right")
        if direction == Directions.still{
            touchToStartLabel.removeFromParent()
            difficulty = 4
            run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addLaser),SKAction.wait(forDuration: 0.5)])))
            run(SKAction.repeatForever(SKAction.sequence([SKAction.run(updateScore), SKAction.wait(forDuration: 0.3)])), withKey: "ScoreLoop")

        }
        direction = Directions.right
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let touchLocation = touch.location(in: self)
        
        if pauseButton.contains(touchLocation){
            let scene = PauseMenu(size: (view?.bounds.size)!)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view?.presentScene(scene)
        }

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
    func initializeMap(){
        
        for i in 0 ..< map.count {
            self.spriteMap.append([])
            for j in 0 ..< map[0].count{
                
                let spriteNode = SKSpriteNode()
                spriteNode.size = CGSize(width: cellSize, height: cellSize)
                spriteNode.position = CGPoint(x: CGFloat(i)*cellSize+cellSize/2, y: CGFloat(j)*cellSize+cellSize/2)
                spriteNode.color = UIColor.black
                addChild(spriteNode)
                self.spriteMap[i].append(spriteNode)
            }
        }
    }
    func takeStep() {
        for laser in laserArray{
            if laser.direction == Directions.up{
                laser.head = CGPoint(x: laser.head.x, y: laser.head.y + 1)
            }else if laser.direction == Directions.down{
                laser.head = CGPoint(x: laser.head.x, y: laser.head.y-1)
            }else if laser.direction == Directions.left{
                laser.head = CGPoint(x: laser.head.x-1, y: laser.head.y)
            }else if laser.direction == Directions.right{
                laser.head = CGPoint(x: laser.head.x+1, y: laser.head.y)
            }
            
            if laser.body.count >= laserLength {
                laser.body.popLast()
            }
            laser.body.insert(CGPoint(x: laser.head.x, y: laser.head.y), at: 0)
            
        }
        updateLaserMap()
        
        if direction == Directions.down{
            if map[currentX][currentY-1] == 1 || laserMap[currentX][currentY-1] > 0 {
                gameOver()

            }else{
                //map[currentX][currentY-1] = 1
                currentY = currentY-1
            }
        }else if direction == Directions.up{
            if map[currentX][currentY+1] == 1 || laserMap[currentX][currentY+1] > 0 {
                gameOver()
            }else{
                //map[currentX][currentY+1] = 1
                currentY = currentY+1
            }
        }else if direction == Directions.left{
            if map[currentX-1][currentY] == 1 || laserMap[currentX-1][currentY] > 0 {
                gameOver()
            }else{
                //map[currentX-1][currentY] = 1
                currentX = currentX-1
                
            }
        }else if direction == Directions.right{
            if map[currentX+1][currentY] == 1 || laserMap[currentX+1][currentY] > 0 {
                gameOver()
            }else{
                //map[currentX+1][currentY] = 1
                currentX = currentX+1
            }
            
        }
        bodyArray.insert(CGPoint(x: currentX, y: currentY),at: 0)

        
        updateMap()
        
    }
    func updateLaserMap(){
        // Clear laser map
        for i in 0 ..< laserMap.count {
            for j in 0 ..< laserMap[0].count{
                laserMap[i][j] = 0
            }
        }
        
        //Insert laser body
        for laser in laserArray{
            for point in laser.body{
                var x = Int(point.x)
                var y = Int(point.y)
                if x >= 0, y >= 0, x < laserMap.count, y < laserMap[0].count{
                    laserMap[x][y] = laser.colorNum
                }
            }
        }
    }
    func updateMapUI(){
        for i in 0 ..< spriteMap.count{
            for j in 0 ..< spriteMap[0].count{
                
                if laserMap[i][j] > 0{
                    spriteMap[i][j].color = getColorBy(colorNum: laserMap[i][j])
                }
                else if map[i][j] == CellValue.body{
                    spriteMap[i][j].color = UIColor.red
                }else if map[i][j] == CellValue.empty{
                    spriteMap[i][j].color = UIColor.black
                }
            }
        }
    }
    func updateMap(){
        for i in 0 ..< map.count {
            for j in 0 ..< map[0].count{
                map[i][j] = 0
            }
        }
        for point in bodyArray {
            var x = Int(point.x)
            var y = Int(point.y)
            if x >= 0, y >= 0, x < map.count, y < map[0].count{
                map[x][y] = CellValue.body
            }
        }
    }
    func getColorBy(colorNum: Int) -> UIColor{
        if colorNum==1{
            return UIColor.blue
        }else if colorNum==2{
            return UIColor.yellow
        }else if colorNum==3{
            return UIColor.purple
        }else if colorNum==4{
            return UIColor.orange
        }else if colorNum==5{
            return UIColor.green
        }else if colorNum==6{
            return UIColor.cyan
        }else if colorNum==7{
            return UIColor.white
        }else{
            return UIColor.brown
        }
        
    }
    
    func randomNumber(range: CountableClosedRange<Int> = 1...4) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func addLaser(){
        //print("Added")
        let rand = randomNumber()
        let head : CGPoint
        if rand == Directions.up{
            head = CGPoint(x: CGFloat(arc4random_uniform(UInt32(map.count))), y: 0)
        }else if rand == Directions.down{
            head = CGPoint(x: CGFloat(arc4random_uniform(UInt32(map.count))), y: CGFloat(map[0].count-1))
        }else if rand == Directions.left{
            head = CGPoint(x: CGFloat(map.count - 1), y: CGFloat(arc4random_uniform(UInt32(map[0].count))))
        }else{
            head = CGPoint(x: 0, y: CGFloat(arc4random_uniform(UInt32(map[0].count))))
        }
        
        let laser = Laser(head: head, direction: rand)
        laserArray.append(laser)
        
    }

    func gameOver(){
        let gameOver = SKLabelNode(fontNamed: "Arial")
        gameOver.position = CGPoint(x: size.width/2, y: size.height/2)
        gameOver.text = "Game Over"
        gameOver.fontSize = 50
        explodeBody()
        addChild(gameOver)
        removeAction(forKey: "GameLoop")
        removeAction(forKey: "ScoreLoop")
        run(SKAction.sequence([SKAction.wait(forDuration: 2.0), SKAction.run(restart)]))
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    func updateScore(){
        score += 1*difficulty
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = UIColor.white
        scoreLabel.text = "Score: \(score)"
        //scoreLabel.fontNameed("Arial")
        
        scoreLabel.position = CGPoint(x: size.width/2, y: 75)
        
    }
    func restart(){
        let scene = GameScene(fileNamed: "GameScene")
        // Set the scale mode to scale to fit the window
        scene?.scaleMode = .aspectFill
        // Present the scene
        view?.presentScene(scene)

    }
    
    func explodeBody(){
        for node in bodyArray{
            let explosions : [SKSpriteNode] = [SKSpriteNode(), SKSpriteNode()/*, SKSpriteNode(), SKSpriteNode(), SKSpriteNode()*/]
            for explosion in explosions {
                explosion.color = UIColor.orange
                explosion.size = CGSize(width: 3, height: 3)
                let posX = spriteMap[Int(node.x)][Int(node.y)].position.x
                let posY = spriteMap[Int(node.x)][Int(node.y)].position.y
                
                explosion.position = CGPoint(x: posX, y: posY)
                addChild(explosion)
            
                let randomExplosionX = (random() * (1000 + size.width)) - size.width
            
                let randomExplosionY = (random() * (1000 + size.height)) - size.width
            
                let moveExplosion: SKAction
            
                moveExplosion = SKAction.move(to: CGPoint(x: randomExplosionX, y: randomExplosionY), duration: 10.0)
                explosion.run(SKAction.sequence([moveExplosion, SKAction.removeFromParent()]))
            }
        }
        map = Array(repeating: Array(repeating: 0, count: Int(size.height/cellSize)), count: Int(size.width/cellSize))
        
        updateMapUI()
    }
 
}
