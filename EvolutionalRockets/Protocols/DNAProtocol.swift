//
//  DNAProtocol.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

protocol DNAProtocol {
    
    var genes: [Int] { get set }
    
    func crossover(with other: DNAProtocol) -> DNAProtocol
    
    mutating func mutate()
}
