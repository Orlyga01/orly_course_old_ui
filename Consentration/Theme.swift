//
//  Theme.swift
//  Consentration
//
//  Created by Orly on 26/01/2021.
//

import Foundation
import SwiftUI


struct Theme {
    var name: String;
    var numberOfPairsOfCards: Int
    var cardBgColor: UIColor?
    var emojiSet: [String]?
    init(name: String, numberOfPairedCard: Int? = nil, cardBgColor: UIColor? = nil, emojiSet: [String]? = nil){
        self.name = name
        if let tmp  = numberOfPairedCard, numberOfPairedCard! > 1 {
            self.numberOfPairsOfCards = numberOfPairedCard!
        } else {
            self.numberOfPairsOfCards = Int.random(in: 2...5)
        }
        self.cardBgColor = cardBgColor
        self.emojiSet = emojiSet ?? randomEmojiArray(numPairedCards: self.numberOfPairsOfCards)
        if  cardBgColor == nil {
            self.cardBgColor = randomColor()
        }
        
    }
    private func randomEmojiArray(numPairedCards: Int)-> [String] {
        let range : ClosedRange = (0x1F300...0x1F3F0)
        var emojiArray: [String] = []
        for _ in 1...numPairedCards {
            let newEmoji = addNewEmoji(range, emojiArray)
            emojiArray.append(newEmoji)
        }
        return emojiArray
    }
    private func addNewEmoji(_ range: ClosedRange<Int>,_ emojiArray: [String] ) -> String {
        let index = Int(arc4random_uniform(UInt32(range.count)))
        let ord = range.lowerBound + index
        let newEmoji =  String(UnicodeScalar(ord)!)
        if (emojiArray.contains(newEmoji)) {
            addNewEmoji(range, emojiArray)
            return ""
        } else {
            return newEmoji
        }
    }
    
    private func randomColor() -> UIColor {
        return UIColor.init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}

