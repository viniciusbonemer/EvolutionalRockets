//
//  Helper.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation
import SpriteKit

struct Random {
    
    static func value(upTo upperbound: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upperbound)))
    }
    
    static func booster() -> CGVector {
        var dx = drand48()
        var dy = drand48()
        dx *= drand48() > 0.5 ? 10 : -10
        dy *= drand48() > 0.5 ? 10 : -10
//        if Random.value(upTo: 2) > 1 { dx *= -1}
//        if Random.value(upTo: 2) > 1 { dy *= -1}
        return CGVector(dx: dx, dy: dy)
    }
}

enum ColliderType: UInt32 {
    case Rocket  = 0
    case Target  = 1
    case Barrier = 2
}


extension CGPoint {
    func distance(to other: CGPoint) -> CGFloat {
        let dx = self.x - other.x
        let dy = self.y - other.y
        
        return sqrt(pow(dx, 2) + pow(dy, 2))
    }
}

extension CGFloat {
    func map(_ iStart: CGFloat, _ iStop: CGFloat, _ oStart: CGFloat, _ oStop: CGFloat) -> CGFloat {
        let dO = (oStop - oStart)
        let dI = (iStop - iStart)
        return oStart + dO * ((self - iStart) / dI)
    }
}

extension CGVector {
    static func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }
    
    static var boosters: [CGVector] {
        return [CGVector(dx: 0, dy: 1) * 10,
                CGVector(dx: -0.707, dy: 0.707) * 10,
                CGVector(dx: 0.707, dy: 0.707) * 10,
                CGVector(dx: -1, dy: 0) * 10,
                CGVector(dx: 1, dy: 0) * 10]
    }
}

extension UIColor {
    static let path = UIColor(red: 46, green: 0, blue: 127, alpha: 0.05)
    static let fill = UIColor(red: 46, green: 0, blue: 127, alpha: 1)
}
