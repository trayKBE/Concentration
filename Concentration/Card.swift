//
//  Card.swift
//  Concentration
//
//  Created by class on 2018/12/19.
//  Copyright © 2018 study. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier:Int
    
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier()  -> Int{
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
