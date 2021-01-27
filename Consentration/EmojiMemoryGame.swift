//
//  EmojiMemoryGame.swift
//  Consentration
//
//  Created by Orly on 21/01/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    // static is not part of the instance of the class so we can use it at any time the class is initiated
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    static func createMemoryGame() -> MemoryGame<String> {
        let emojiArray: Array<String> = ["☠️", "🤢", "🤖","😈","👍"]
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { index in
            return emojiArray[index]
        }
    }
    init(){
        
    }
    //MARK: access to model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    var numberOfPairsOfCards: Int {
        cards.count / 2
    }
    // MARK: - intents
    func choose(card: MemoryGame<String>.Card, index: Int) {
        model.choose(card: card, index: index)
    }
    
    
}
