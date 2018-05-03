//
//  GameScene.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import SpriteKit
import GameplayKit

class SimulationScene: SKScene {
    
    override func didMove(to view: SKView) {
        // Set up background
        let background = SKSpriteNode(color: .darkGray, size: view.bounds.size)
        background.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        addChild(background)
    }
}
