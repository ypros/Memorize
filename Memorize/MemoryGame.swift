//
//  MemoryGame.swift
//  Memorize
//
//  Created by YURY PROSVIRNIN on 09.11.2022.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        if let chosenCardIndex = cards.firstIndex(where: { $0.id == card.id}) {
            cards[chosenCardIndex].isFaceUp.toggle()
        }
    }

    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairs {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
            
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
