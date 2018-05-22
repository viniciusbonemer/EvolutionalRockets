//
//  GameScene.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import SpriteKit
import GameplayKit

class SimulationScene: SKScene {
    
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
//    var barrier = BarrierNode()
    
    
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
        
//        target = childNode(withName: "target") as! TargetNode
        rocketLaucher = childNode(withName: "rocketLauncher")
//        barrier = childNode(withName: "centralBarrier") as! BarrierNode
        lifespan = population.population.first!.model.dna.genes.count
        
        for rocket in population.population {
            rocket.position = rocketLaucher.position
            addChild(rocket)
        }
    }
    
    
    func fillMattingPool() {
        var maxFitness = population.population[0].model.fitness
        for rocket in population.population {
            if rocket.model.fitness > maxFitness {
                maxFitness = rocket.model.fitness
            }
        }
        var sum = 0
        for rocket in population.population {
            rocket.model.fitness /= maxFitness
//            print(rocket.model.fitness)
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
        print("Max Fitness: \(maxFitness)")
        print("Average count: \(sum/population.population.count)")
        print("Mating pool size: \(matingPool.count)")
    }
    
    
    func drawTrajectory(of rocket: RocketNode) {
        let trajectory = rocket.trajectory
        guard !trajectory.isEmpty else { print("NO stroke");return }
//        guard drand48() > 0.5 else { return }
//        UIGraphicsGetCurrentContext()
//        let pathColor = UIColor(red: 46, green: 0, blue: 127, alpha: 0.01)
//        let path = SKShapeNode(path: trajectory.cgPath)
//        path.lineWidth = 1
//        path.strokeColor = pathColor
//        path.alpha = 0.01
//        addChild(path)
        drawingView.paths.append(trajectory)
        print("stroke")
    }
    
    
    func performSelection() {
        var newPopulation = [RocketNode]()
        for _ in 0..<population.population.count {
            let indexA = Random.value(upTo: matingPool.count)
            let indexB = Random.value(upTo: matingPool.count)
            
            let parentA = matingPool[indexA]
            let parentB = matingPool[indexB]
            
            let childModel = parentA.makeDescendant(with: parentB) as! Rocket
            let child = RocketNode(model: childModel)
            newPopulation.append(child)
        }
        population = Population(from: newPopulation)
        for rocket in population.population {
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
//            clearLines()
            currentCycle = 0
            return
        }
        
        population.simulate()
        currentCycle += 1
        label2.text = String(currentCycle)
    }
    
//    func clearLines() {
//        if lines.count > 100 {
//            for _ in 0..<50 {
//                let line = lines.remove(at: 0)
//                line.removeFromParent()
//            }
//        }
//    }
}

extension SimulationScene: SKPhysicsContactDelegate {
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let rocket: RocketNode
        let other: SKNode
        if contact.bodyA.node is RocketNode {
            rocket = contact.bodyA.node as! RocketNode
            other = contact.bodyB.node!
        } else if contact.bodyB.node is RocketNode {
            rocket = contact.bodyB.node as! RocketNode
            other = contact.bodyA.node!
        } else {
            return
        }
        
        switch other {
        case is TargetNode:
            rocket.didReachTarget = true
//            print("TARGET HIT")
        case is BarrierNode:
            rocket.didCrash = true
//            print("HIT BARRIER")
        default:
            break
        }
        
        rocket.physicsBody?.isDynamic = false
        rocket.finished = true
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let location = touch.location(in: self)
//            barrier.position = location
//        }
//    }
}
