//
//  RocketNode.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation
import SpriteKit

class RocketNode: SKSpriteNode {
    
    var model: Rocket = Rocket()
    
    var boosters: [CGVector] = CGVector.boosters
    
    var didReachTarget = false
    var didCrash = false
    var finished = false
    
    var trajectory = UIBezierPath()
    
    var currentGene = 0
    
    lazy var reference: SKNode = (self.parent?.childNode(withName: "referenceNode"))!
    
    init() {
        let size = CGSize(width: 10, height: 50)
        super.init(texture: nil, color: .white, size: size)
        self.alpha = 0.5
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.categoryBitMask = ColliderType.Rocket.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Target.rawValue | ColliderType.Barrier.rawValue
        self.physicsBody?.contactTestBitMask = ColliderType.Target.rawValue | ColliderType.Barrier.rawValue
        physicsBody?.linearDamping = 0.6
    }
    
    convenience init(model: Rocket) {
        self.init()
        self.model = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    deinit {
        self.removeAllActions()
        self.removeFromParent()
    }
    
    
    func evaluateFitness(target: TargetNode) {
        let distanceToTarget = didReachTarget ? 0 : self.position.distance(to: target.position)
        var fitness = distanceToTarget.map(0, 5000, 100, 0)
        
        if didCrash {
            fitness /= 10
        }
        
        if didReachTarget {
            fitness *= 10
        }
        
        self.model.fitness = Double(fitness)
    }
    
    
    func executeDNA() {
        guard currentGene < model.dna.genes.count else { print("big gene"); return }
        guard !finished else { return }
        guard !didCrash, !didReachTarget else { return }
        
        let boosterToFire = model.dna.genes[currentGene]
        let boost = boosters[boosterToFire]
        physicsBody?.applyForce(boost)
        currentGene += 1
        if currentGene % 10 == 0 {
            let pos = (self.scene?.view?.convert(position, from: scene!))!
            if trajectory.isEmpty {
                trajectory.move(to: pos)
            } else {
                trajectory.addLine(to: pos)
            }
        }
    }
}
