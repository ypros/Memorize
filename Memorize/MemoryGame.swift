//
//  MemoryGame.swift
//  Memorize
//
//  Created by YURY PROSVIRNIN on 09.11.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexFaceUpCard: Int? {
        get {
            cards.indices.filter({ cards[$0].isFaceUp && !cards[$0].isMatched}).oneAndOnly
        }
        set {
            cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue || cards[$0].isMatched)})
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenCardIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenCardIndex].isFaceUp,
           !cards[chosenCardIndex].isMatched
        {
            if let potentialMatchIndex = indexFaceUpCard {
                if cards[potentialMatchIndex].content == cards[chosenCardIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenCardIndex].isMatched = true
                }
                cards[chosenCardIndex].isFaceUp = true
            }
            else {
 
                indexFaceUpCard = chosenCardIndex

            }
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
        let id: Int
        let content: CardContent
        
        var isFaceUp = false
        var isMatched = false
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
