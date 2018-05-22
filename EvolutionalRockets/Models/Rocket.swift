//
//  Rocket.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

class Rocket: IndividualProtocol {
    
    var dna: DNAProtocol
    
    var fitness: Double = 0
    
    init() {
        self.dna = DNA()
    }
    
    init(with dna: DNA) {
        self.dna = dna
    }
    
    func makeDescendant(with other: IndividualProtocol) -> IndividualProtocol {
        let newDNA = self.dna.crossover(with: other.dna) as! DNA
        return Rocket(with: newDNA)
    }
}
