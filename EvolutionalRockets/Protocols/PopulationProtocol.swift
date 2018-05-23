//
//  PopulationProtocol.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 03/05/2018.
//

import Foundation

protocol  PopulationProtocol {
    
    associatedtype Individual: IndividualProtocol
    
    var individuals: [Individual] { get set }
    var size: Int { get }
    
    subscript (_: Int) -> Individual { get set }
}
