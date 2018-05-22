//
//  DNA.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

struct DNA: DNAProtocol {
    
    static var mutationRate = 0.01
    
    static var length: Int = 300
    
    static var maxValue: Int = 5 {
        didSet {
            if maxValue <= 0 {
                maxValue = 1
            }
        }
    }
    
    var genes: [Int] = {
        var information = [Int]()
        for _ in 0..<DNA.length {
            let randomValue = Random.value(upTo: DNA.maxValue)
            information.append(randomValue)
        }
        return information
    }()
    
    
    init() { }
    
    
    init(from information: [Int]) {
        self.init()
        if information.count == DNA.length,
            information.max()! < DNA.maxValue {
            genes = information
        } else {
            print("error with genes")
        }
    }
    
    
    func crossover(with other: DNAProtocol) -> DNAProtocol {
        
        var newDNAInformation = [Int]()
        let randomIndex = Random.value(upTo: DNA.length)
//        print("CROSSOVER POINT: \(randomIndex)")
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
            print("MUTATION!")
        }
    }
}
