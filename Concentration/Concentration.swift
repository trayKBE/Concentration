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
    
   
    
    /*
     1.if index card is matched, nothing to do
     2.if index card is unmatched, let it match with onlyFaceup card,
 
    */
    
    func chooseCard(at index : Int){
        
        if !cards[index].isMatched {
            
          
            if let matchIndex = indexOfOneAndOnlyFaceAndCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    
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
        }
    }
    
 
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card =  Card()
            
            cards += [card,card]
        }
    }
}
