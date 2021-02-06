//
//  Card.swift
//  Concentration
//
//  Created by Ruben on 11/30/17.
//  Copyright © 2017 Ruben. All rights reserved.
//
import Foundation
import UIKit
///
/// Represents a "Card" that is used in the "Concentration" game
///

struct Card: Hashable {
    var isMatched: Bool? = nil
    var isSelected = false
    var identifier: Int
    var text: String?
    var position: CardPosition?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    ///
 
    /// Create a card with the given identifier
    ///
    init(text: String) {
        self.text = text
        self.identifier = Card.getUniqueIdentifier()
    }
    
    ///
    /// Static identifier that is increased every time a new one is
    /// requested by getUniqueIdentifier()
    ///
    static var identifierFactory = 0
    
    ///
    /// Returns a unique id to be used as a card identifier
    ///
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
   
}
struct CardPosition {
    var x: CGFloat
    var y: CGFloat
    var available: Bool = true
}


