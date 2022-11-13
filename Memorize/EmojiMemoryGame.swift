//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by YURY PROSVIRNIN on 09.11.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let  emojis = ["🚗", "🛻", "🛺", "🚁", "🛵", "🚙", "🚑", "🏍", "🏎", "🚜", "🚃", "🚂", "🚁", "🚤", "🚛", "🚒", "🚓", "🚚", "🚕"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairs: 10) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
