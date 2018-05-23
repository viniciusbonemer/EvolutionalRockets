//
//  Rocket.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

final class Rocket: IndividualProtocol {
    
    // MARK: Properties

    var dna: DNA

    var fitness: Double = 0

    // MARK: - Initialization
    
    init() {
        self.dna = DNA()
    }

    init(with dna: DNA) {
        self.dna = dna
    }
    
    // MARK: - Methods

    func makeDescendant(with other: Rocket) -> Rocket {
        let newDNA = self.dna.crossover(with: other.dna)
        return Rocket(with: newDNA)
    }
}
