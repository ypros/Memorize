//
//  MemoryGame.swift
//  Memorize
//
//  Created by YURY PROSVIRNIN on 09.11.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexFaceUpCard: Int?
    
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
                indexFaceUpCard = nil
            }
            else {
                for index in cards.indices {
                    cards[index].isFaceUp = cards[index].isMatched
                }
                indexFaceUpCard = chosenCardIndex
                
                //print(chosenCardIndex)
            }
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
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
