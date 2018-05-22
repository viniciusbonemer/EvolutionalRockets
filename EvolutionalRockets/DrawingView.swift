//
//  DrawingView.swift
//  EvolutionalRockets
//
//  Created by Vinícius Bonemer on 07/05/2018.
//

import UIKit

class DrawingView: UIView {

    var paths: [UIBezierPath] = [UIBezierPath]()
    
    
    override func draw(_ rect: CGRect) {
        while paths.count > 300 {
            paths.removeFirst()
        }
        
        UIColor.path.setStroke()
        for path in paths {
            path.stroke()
        }
    }
 

}
