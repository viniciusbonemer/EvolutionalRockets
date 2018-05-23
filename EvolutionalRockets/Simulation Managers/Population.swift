//
//  Population.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

class Population: PopulationProtocol {
    
    // MARK: - Properties
    
    var individuals: [RocketNode]
    
    let size: Int
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(of: 100)
    }
    
    
    init(of size: Int) {
        self.size = size
        individuals = [RocketNode]()
        for _ in 0..<size {
            individuals.append(RocketNode())
        }
    }
    
    init(from array: [RocketNode]) {
        self.size = array.count
        individuals = array
    }
    
    
    deinit {
        for _ in individuals {
            let rocket = individuals.remove(at: 0)
            rocket.removeAllActions()
            rocket.removeFromParent()
        }
    }
    
    // MARK: - Subscript
    
    
    subscript(_ index: Int) -> RocketNode {
        get {
            return individuals[index]
        }
        set {
            individuals[index] = newValue
        }
    }
    
    
    // MARK: - Methods
    
    func simulate() {
        for rocket in individuals {
            if !rocket.didCrash, !rocket.didReachTarget {
                rocket.executeDNA()
            }
        }
    }
    
    
    func calculateFitness(target: TargetNode) {
        for rocket in individuals {
            rocket.evaluateFitness(target: target)
        }
    }
}

