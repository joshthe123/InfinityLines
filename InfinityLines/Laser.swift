//
//  Laser.swift
//  InfinityLines
//
//  Created by iD Student on 8/7/17.
//  Copyright © 2017 iD Tech. All rights reserved.
//

import Foundation
import SpriteKit

class Laser {
    var head : CGPoint
    let length : Int = 15
    var color : UIColor
    var colorNum : Int = 0
    var direction : Int
    var body : [CGPoint]
    
    init(head : CGPoint, direction : Int){
        self.head = head
        self.direction = direction
        color = UIColor.white
        body = [CGPoint(x: head.x, y: head.y)]
        color = randomColor()
        
    }
    
    func randomNumber(range: CountableClosedRange<Int> = 1...8) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func randomColor() -> UIColor{
        colorNum = randomNumber()
        
        return getColorBy(colorNum: colorNum)
    
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

}
