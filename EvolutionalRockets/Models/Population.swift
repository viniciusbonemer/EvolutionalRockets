//
//  Population.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

class Population {
    
    
    var population: [RocketNode]
    
    var size: Int
    
    
    convenience init() {
        self.init(of: 100)
    }
    
    
    init(of size: Int) {
        self.size = size
        population = [RocketNode]()
        for _ in 0..<size {
            population.append(RocketNode())
        }
    }
    
    init(from array: [RocketNode]) {
        self.size = array.count
        population = array
    }
    
    
    deinit {
        for _ in population {
            let rocket = population.remove(at: 0)
            rocket.removeAllActions()
            rocket.removeFromParent()
        }
    }
    
    
    subscript(_ index: Int) -> RocketNode {
        get {
            return population[index]
        }
        set {
            population[index] = newValue
        }
    }
    
    func simulate() {
        for rocket in population {
            if !rocket.didCrash, !rocket.didReachTarget {
                rocket.executeDNA()
            }
        }
    }
    
    
    func calculateFitness(target: TargetNode) {
        for rocket in population {
            rocket.evaluateFitness(target: target)
        }
    }
    
}
