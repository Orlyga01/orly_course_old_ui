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
    private var gameSets: [String] = [String]()

    init() {
        cards = [Card]()
        for i in 0...2 {
            for y in 0...2 {
                for z in 0...2 {
                    for a in 0...2 {
                    gameSets.append(String(i) + String(y) + String(z) + String(a))
                    }
                }
            }
        }
    }
    mutating func startGame() {
        addMoreCards(initialDisplayCards)
    }
    mutating func addMoreCards(_ num: Int) {
        for _ in 1...num {
            cards.append(Card(text: setCardContent()))
        }
    }
    mutating func setCardContent() -> String {
        let randomElement: Int = Int.random(in: 0..<gameSets.count )
        let element = gameSets[randomElement]
        gameSets.remove(at: randomElement)
        return element
    }
}


