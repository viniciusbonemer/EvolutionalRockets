//
//  GameScene.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import SpriteKit
import GameplayKit

class SimulationScene: SKScene {
    
    // MARK: - Properties
    
    var label: SKLabelNode = {
        let l = SKLabelNode(text: "1")
        l.position = CGPoint(x: 320, y: 300)
        return l
    }()
    
    var label2: SKLabelNode = {
        let l = SKLabelNode(text: "1")
        l.position = CGPoint(x: 320, y: 200)
        return l
    }()
    
    var drawingView: DrawingView!
    
    var rocketLaucher: SKNode!
    var population = Population()
    var matingPool = [Rocket]()
    var lifespan = 0
    var currentCycle = 0
    
    var target = TargetNode()
    
    
    // MARK: - Methods
    
    override func sceneDidLoad() {
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        target.position = childNode(withName: "targetPosition")!.position
        addChild(target)
        addChild(label)
        addChild(label2)
    }
    
    
    override func didMove(to view: SKView) {
        drawingView = DrawingView(frame: view.frame)
        drawingView.backgroundColor = .clear
        view.addSubview(drawingView)
        
        rocketLaucher = childNode(withName: "rocketLauncher")
        lifespan = DNA.length
        
        for rocket in population.individuals {
            rocket.position = rocketLaucher.position
            addChild(rocket)
        }
    }
    
    
    func fillMattingPool() {
        var maxFitness = population[0].model.fitness
        for rocket in population.individuals {
            if rocket.model.fitness > maxFitness {
                maxFitness = rocket.model.fitness
            }
        }
        var sum = 0
        for rocket in population.individuals {
            rocket.model.fitness /= maxFitness
            let count = Int(rocket.model.fitness * 1000)
            sum += count
            print(count)
            if count <= 0 { continue }
            for _ in 0..<count {
                matingPool.append(rocket.model)
            }
            drawTrajectory(of: rocket)
        }
        drawingView.setNeedsDisplay()
    }
    
    
    func drawTrajectory(of rocket: RocketNode) {
        let trajectory = rocket.trajectory
        guard !trajectory.isEmpty else { return }
        drawingView.paths.append(trajectory)
    }
    
    
    func performSelection() {
        var newIndividuals = [RocketNode]()
        for _ in 0..<population.individuals.count {
            let indexA = Random.value(upTo: matingPool.count)
            let indexB = Random.value(upTo: matingPool.count)
            
            let parentA = matingPool[indexA]
            let parentB = matingPool[indexB]
            
            let childModel = parentA.makeDescendant(with: parentB)
            let child = RocketNode(from: childModel)
            newIndividuals.append(child)
        }
        population = Population(from: newIndividuals)
        for rocket in population.individuals {
            rocket.position = rocketLaucher.position
            addChild(rocket)
        }
        label.text = String(Int(label.text!)! + 1)
        matingPool = []
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        guard currentCycle < lifespan else {
            population.calculateFitness(target: target)
            fillMattingPool()
            performSelection()
            currentCycle = 0
            return
        }
        
        population.simulate()
        currentCycle += 1
        label2.text = String(currentCycle)
    }
}

extension SimulationScene: SKPhysicsContactDelegate {
    
    struct UnsovableContact: Error {
        var localizedDescription: String = "The types involved are not the required ones"
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var rocket = RocketNode()
        var other = SKNode()
        
        do {
            try solveContact(contact, rocket: &rocket, other: &other)
        } catch {
            print(error)
        }
            
        switch other {
        case is TargetNode:
            rocket.didReachTarget = true
        case is BarrierNode:
            rocket.didCrash = true
        default:
            break
        }
        
        rocket.physicsBody?.isDynamic = false
        rocket.finished = true
    }
    
    func solveContact(_ contact: SKPhysicsContact, rocket: inout RocketNode, other: inout SKNode) throws {
        if contact.bodyA.node is RocketNode {
            rocket = contact.bodyA.node as! RocketNode
            other = contact.bodyB.node!
        } else if contact.bodyB.node is RocketNode {
            rocket = contact.bodyB.node as! RocketNode
            other = contact.bodyA.node!
        } else {
            throw UnsovableContact()
        }
    }
}
