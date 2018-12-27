//
//  ViewController.swift
//  Concentration
//
//  Created by class on 2018/12/12.
//  Copyright © 2018 study. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flipLabel: UILabel!
    @IBOutlet var actionButtons: [UIButton]!
    
    // var game: Concentration?
    lazy  var game = Concentration(numberOfPairsOfCards:(actionButtons.count + 1)/2 )
   // var emojis = ["👻", "🎃" , "♦️" , "♠️"]
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        if let cardNumber = actionButtons.index(of:sender) {
            print("index of button is \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
          //  flipCard(withEmoji: emojis[cardNumber], sender: sender)
        }else{
            print("button is not contain")
        }
       
//        print("ghost")
       
    }
  
    //"😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊","🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","⌚️","📱","📲","💻","⌨️","🖥","🖨","🖱","🖲","🕹"
    
  //  var emojiSource = [["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"],["😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊"],["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯"],["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈"],["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸"],["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐"]]
    
   
    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎","🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐"]
    
    
    var emoji = [Int: String]()
 
    
    

    
    func updateViewFromModel() {
      
        
        for index in actionButtons.indices {
            let button = actionButtons[index]
            let card = game.cards[index]
            if !card.isFaceUp {
                button.setTitle("", for:UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }else{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
    
    
    
    func emoji(for card:Card) -> String? {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
             emoji[card.identifier] = emojiChoices.remove(at: randomIndex)

        }
        return emoji[card.identifier] ?? "?"
      //  return "?"
    }
    
    
    
  
    
    
    
    func flipCard(withEmoji:String, sender :UIButton){
        if sender.currentTitle == withEmoji {
            sender.setTitle("", for: UIControl.State.normal)
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }else{
            sender.setTitle(withEmoji, for: UIControl.State.normal)
            sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

