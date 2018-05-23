//
//  DNA.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

struct DNA: DNAProtocol {
    
    // MARK: - Properties
    
    static var mutationRate = 0.01
    
    static let length: Int = 300
    
    static let maxValue: Int = 5
    
    var genes: [Int] = {
        var information = [Int]()
        for _ in 0..<DNA.length {
            let randomValue = Random.value(upTo: DNA.maxValue)
            information.append(randomValue)
        }
        return information
    }()
    
    // MARK: - Initialization
    
    init() { }
    
    
    init(from information: [Int]) {
        self.init()
        if information.count == DNA.length,
            information.max()! < DNA.maxValue {
            genes = information
        } else {
            print("Error with provided genes. Random values are beeing used instead. ")
        }
    }
    
    // MARK: - Methods
    
    func crossover(with other: DNA) -> DNA {
        
        var newDNAInformation = [Int]()
        let randomIndex = Random.value(upTo: DNA.length)
        for index in 0..<DNA.length {
            if index < randomIndex {
                newDNAInformation.append(self.genes[index])
            } else {
                newDNAInformation.append(other.genes[index])
            }
        }
        return DNA(from: newDNAInformation)
    }
    
    
    mutating func mutate() {
        let randomIndex = Random.value(upTo: DNA.length)
        if drand48() < DNA.mutationRate {
            let randomGene = Random.value(upTo: DNA.maxValue)
            genes[randomIndex] = randomGene
        }
    }
    
    
    // MARK: - Subscript
    
    subscript(index: Int) -> Int {
        get {
            return genes[index]
        }
        set {
            genes[index] = newValue
        }
    }
}
