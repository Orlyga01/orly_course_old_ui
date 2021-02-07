//
//  Set.swift
//  Set
//
//  Created by Orly on 03/02/2021.
//

import Foundation
import UIKit

struct SetGame {
    private var positions: [CardPosition]=[CardPosition]()
    var cards: [Card] = [Card]()
    let initialDisplayCards: Int =  12
    let maxDisplayCards: Int =  24
    let addedCards: Int = 3
    var addCardsAllowed: Bool = true
    private var gameSets: [String] = [String]()
    private var openCards: [Card] = [Card]()

    init() {
        cards = [Card]()
        for i in 0...addedCards - 1 {
            for y in 0...addedCards - 1{
                for z in 0...addedCards - 1 {
                    for a in 0...addedCards - 1 {
                    gameSets.append(String(i) + String(y) + String(z) + String(a))
                    }
                }
            }
        }
    }
    mutating func startGame() {
        addMoreCards(initialDisplayCards)
    }
    mutating func addMoreCards(_ num: Int?) {
        let cardno = num ?? addedCards
        if (cards.count > maxDisplayCards-addedCards) || (Int(pow(Double(addedCards), 4)) <=  cards.count) {
            addCardsAllowed = false;
        } else {
            for _ in 1...cardno {
                cards.append(Card(text: setCardContent()))
                addCardsAllowed = !(cards.count == maxDisplayCards );
            }
        }
       
    }
    mutating func setCardContent() -> String {
        let randomElement: Int = Int.random(in: 0..<gameSets.count )
        let element = gameSets[randomElement]
        gameSets.remove(at: randomElement)
        return element
    }
    
    mutating func removeSelectedMatchedCards() {
        for card in openCards {
            let firstIndex = IndexById(card.identifier, cards)
            cards.remove(at: firstIndex);
        }
    }
    
    mutating func resetSelectedUnMatched() {
        for card in openCards {
            let firstIndex = IndexById(card.identifier, cards)
            cards[firstIndex].isSelected = false
            cards[firstIndex].isMatched = nil
        }
    }
    
    mutating func chooseCard(_ cardId: Int) {

        // nisso how can I get a pointer to an item in array
        // missing pointer to element in array
        let index = IndexById(cardId, cards)
        cards[index].isSelected = !cards[index].isSelected
        // clicked twice - then it was unselected we need to remove form the selected array
        if !cards[index].isSelected && openCards.count < 3 {
            openCards.remove(at: IndexById(cardId, openCards))
            return
        }
        if (openCards.count == addedCards) {
            //if its the first card of a set - we need to set all remaining cards as not chossen
            // and if there was a match we need to make this card disappear and add new cards if possible
            let firstIndex = IndexById(openCards[0].identifier, cards)
            if cards[firstIndex].isMatched! {
                removeSelectedMatchedCards()
                addMoreCards(addedCards)
            } else {
                resetSelectedUnMatched()
            }
            openCards.removeSubrange(0...addedCards - 1)

        }
        openCards.append(cards[index])
        if openCards.count == addedCards {
            checkIsMatched()
        }
        
    }
    
    mutating private func checkIsMatched() {
        let firstCardtext = openCards[0].text!
        var index: Int = 0
        for _ in firstCardtext{
            let digit: Int  = Int(firstCardtext[index])!
                if (checkDigitsInPosition(digit, index)) {
                    setMatched(isMatched: true)
                    return
            }
            index += 1
        }
        setMatched(isMatched: false)
        
    }
    mutating private func setMatched( isMatched: Bool) {
        for i in openCards.indices {
            let indexOfCard =  cards.firstIndex(of: openCards[i])!
            cards[indexOfCard].isMatched = isMatched
        }
    }
    
    private func checkDigitsInPosition(_ digit: Int, _ position: Int) -> Bool {
        for i in 1..<openCards.count {
            let checkedDigit = Int(openCards[i].text![position])
            if checkedDigit != digit {
                return false
            }
        }
        return true
    }
    
    func IndexById( _ id: Int, _ array: [Card]?) -> Int {
        let arr = array ?? cards
        for index in arr.indices {
            if arr[index].identifier == id {
                return index
            }
        }
        return -1
        
    }
     
}
extension StringProtocol {
    subscript(offset: Int) -> String {
        String(self[index(startIndex, offsetBy: offset)])
    }
}




