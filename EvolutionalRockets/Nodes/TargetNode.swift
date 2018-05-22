//
//  TargetNode.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation
import SpriteKit

class TargetNode: SKShapeNode {
    
    convenience override init() {
        let size = CGSize(width: 100, height: 100)
        self.init(with: size)
    }
    
    init(with size: CGSize) {
        super.init()
        
        self.path = SKShapeNode(ellipseOf: size).path
        self.fillColor = .fill
        self.strokeColor = .fill
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.categoryBitMask = ColliderType.Target.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Rocket.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        self.removeAllActions()
        self.removeFromParent()
    }
}
