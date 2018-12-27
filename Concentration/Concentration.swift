//
//  Concentration.swift
//  Concentration
//
//  Created by class on 2018/12/19.
//  Copyright © 2018 study. All rights reserved.
//

import Foundation

class Concentration{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceAndCard: Int?
    
    var score = 0
    var flipCount = 0
    
    var chooseIdentifiers = [Int]();
    
    /*
     1.if index card is matched, nothing to do
     2.if index card is unmatched, let it match with onlyFaceup card,
 
    */
    
    func chooseCard(at index : Int){
        
        flipCount += 1
        
        if !cards[index].isMatched {
            
          
            if let matchIndex = indexOfOneAndOnlyFaceAndCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    
                    score += 2;
                }else{
                    if chooseIdentifiers.contains(cards[index].identifier) {
                        score -= 1
                    }
                    if chooseIdentifiers.contains(cards[matchIndex].identifier){
                        score -= 1
                    }
                    if !chooseIdentifiers.contains(cards[index].identifier){
                        chooseIdentifiers.append(cards[index].identifier)
                    }
                    if !chooseIdentifiers.contains(cards[matchIndex].identifier){
                        chooseIdentifiers.append(cards[matchIndex].identifier)
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceAndCard = nil
            }else{
                for downIndex in cards.indices {
                    cards[downIndex].isFaceUp = false
                }
                indexOfOneAndOnlyFaceAndCard = index
                cards[index].isFaceUp = true
            }
            
            print("current score is \(score)")
        }
    }
    
 
    
    init(numberOfPairsOfCards: Int){
        cards = []
        indexOfOneAndOnlyFaceAndCard = nil
        score = 0
        flipCount = 0
        for _ in 1...numberOfPairsOfCards {
            let card =  Card()
            
            cards += [card,card]
        }
        
        cards = cards.shuffled()
    }
}
