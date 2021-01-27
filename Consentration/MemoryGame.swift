//
//  MemoryGame.swift
//  Consentration
//
//  Created by Orly on 21/01/2021.
//

import Foundation
//<CardContent> since we are using an unknown type - the world outside needs to know
//This will be defined by the one who's initiating a MemoryGame class MemoryGame<string>
struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var firstCard: Card?
    mutating func choose(card: Card, index: Int) -> Void{
        if (index > -1) {
            self.cards[index].isFaceUp = true
            if (firstCard == nil) {
                firstCard = card;
                for ind in cards.indices {
                    if ind != index {
                        self.cards[ind].isFaceUp = false
                    }
                }
            } else {
                let firstCardIndex = cards.firstIndex(firstCard!)
                if (self.cards[index].content == self.cards[firstCardIndex!].content) {
                    self.cards[index].isMatched = true
                    self.cards[firstCardIndex!].isMatched = true
                }
                
                firstCard = nil
                
            }
            
        }
    }
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
       cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            var random: Int = (cards.count > 0) ? Int.random(in: 0...cards.count) : 0;
            cards.insert( Card(content: cardContentFactory(pairIndex),id: pairIndex * 2), at: random)
             random = (cards.count > 0) ? Int.random(in: 0...cards.count) : 0;
            cards.insert( Card(content: cardContentFactory(pairIndex), id: pairIndex * 2 + 1), at: random)

        }
    }
   
    // need the identifi so we can itterate through the cards
    struct Card: Identifiable {
        var  isFaceUp: Bool = false
        var  isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
}
extension Array where Element: Identifiable {
    
    func firstIndex(_ matching: Element) -> Int? {
        for index in 0..<self.count {
            if (self[index].id == matching.id) {
                           return index
                       }
        }
        
        return nil
    }
}
