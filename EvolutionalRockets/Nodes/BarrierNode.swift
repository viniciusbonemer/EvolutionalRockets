//
//  BarrierNode.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation
import SpriteKit

class BarrierNode: SKSpriteNode {
    
    
    convenience init() {
        let size = CGSize(width: 100, height: 100)
        self.init(with: size)
    }
    
    init(with size: CGSize) {
        super.init(texture: nil, color: .white, size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.categoryBitMask = ColliderType.Barrier.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Rocket.rawValue
        
        self.physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        self.removeAllActions()
        self.removeFromParent()
    }
}
