//
//  IndividualProtocol.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

protocol IndividualProtocol {
    
    associatedtype DNA: DNAProtocol
    
    var dna: DNA { get set }
    var fitness: Double { get set }
    
    func makeDescendant(with other: Self) -> Self
}
