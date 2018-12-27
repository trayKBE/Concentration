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
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
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
   // print("ghost")
    //"😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊","🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","⌚️","📱","📲","💻","⌨️","🖥","🖨","🖱","🖲","🕹"
    
  //  var emojiSource = [["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"],["😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊"],["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯"],["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈"],["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸"],["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐"]]
    
   
    var emojiSource = [Theme]()
    
    
    var emoji = [Int: String]()
    var viewBackground:UIColor?
    var cardBackColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    var beginDate: Date?
    var endDate = Date(){
        didSet{
          //  print(endDate)
            if beginDate != nil {
                let duration = endDate.timeIntervalSince(beginDate!)
           //     print(duration)
                
                let average = duration/Double(game.flipCount);
                if average < 1{
                    self.DateLabel.text = "Good Score"
                }else{
                    self.DateLabel.text = "Bad Score"
                }
            }else{
                self.DateLabel.text = "Good Score"
            }
        }
    }
    
    
    func getEmojiChoose() -> [String]{
       
        let themeFavourite = Theme(emojis: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎","🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐"], cardBackColor:#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), backgroundColor: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))
       emojiSource.append(themeFavourite)
        
        let themeEmoji = Theme(emojis: ["😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊","⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸"], cardBackColor: #colorLiteral(red: 0.7839296989, green: 0.4299859362, blue: 1, alpha: 1), backgroundColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        emojiSource.append(themeEmoji)
        
        
        
      //  emojiSource.append(["⌚️","📱","📲","💻","⌨️","🖥","🖨","🖱","🖲","🕹"])
        let randomIndex = Int(arc4random_uniform(UInt32(emojiSource.count - 1)))
        
        let randomTheme = emojiSource[randomIndex]
        self.cardBackColor = randomTheme.cardBackColor
        self.viewBackground = randomTheme.backgroundColor
        
        return randomTheme.emojis
    }
    
    
   lazy var emojiChoices = getEmojiChoose()
    
    
    func updateViewFromModel() {
        if beginDate == nil {
            beginDate = Date()
        }
        endDate = Date()
        scoreLabel.text = "Score:\(game.score)"
        flipLabel.text = "flip:\(game.flipCount)"
        self.view.backgroundColor = self.viewBackground
        
        for index in actionButtons.indices {
            let button = actionButtons[index]
            let card = game.cards[index]
            if !card.isFaceUp {
                button.setTitle("", for:UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : self.cardBackColor
            }else{
                print(index)
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
    
    
    
    @IBAction func newGame(_ sender: UIButton) {
        emoji = [Int: String]()
  //
        emojiChoices = getEmojiChoose()
      //  emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
       
     //   game = nil;
        game = Concentration(numberOfPairsOfCards:(actionButtons.count + 1)/2 )
        print("game card \(game.cards.count)")
        
        beginDate = nil
        endDate = Date()
        updateViewFromModel()
        
        
      //  game = nil
      //  lazy game = Concentration(numberOfPairsOfCards:(actionButtons.count + 1)/2 )
        
    }
    
    
    
    
//    func flipCard(withEmoji:String, sender :UIButton){
//        if sender.currentTitle == withEmoji {
//            sender.setTitle("", for: UIControl.State.normal)
//            sender.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
//        }else{
//            sender.setTitle(withEmoji, for: UIControl.State.normal)
//            sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        }
//    }
}

