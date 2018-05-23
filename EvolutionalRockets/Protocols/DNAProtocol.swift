//
//  DNAProtocol.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

protocol DNAProtocol {
    
    associatedtype Gene
    
    var genes: [Gene] { get set }
    
    func crossover(with other: Self) -> Self
    
    mutating func mutate()
    
    subscript(index: Int) -> Gene { get set }
}
