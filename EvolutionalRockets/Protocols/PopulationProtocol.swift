//
//  PopulationProtocol.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

protocol  PopulationProtocol {
    var population: [IndividualProtocol] { get set }
    var size: Int { get }
    
    subscript (_: Int) -> IndividualProtocol { get set }
}
