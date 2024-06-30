//
//  PlayingCardData.swift
//  21
//
//  Created by Zachary Hillman on 6/28/24.
//

import Foundation
import SwiftUI

/*
 Returns data needed for the PlayingCard() view, default will randomize the type and set the card to face down
 
 - Parameter type: A String that determines the type of card
 - Parameter isFaceUp: A Bool that determines if the card is face up or face down
 */
class CardData: ObservableObject, Identifiable {
    @Published var id = UUID()
    @Published var type: String
    @Published var isFaceUp: Bool = false
    @Published var frontDegrees: CGFloat = -90.0
    @Published var backDegrees: CGFloat = 0.0
    @Published private var DurationAndDelay = 0.3
    
    init() {
        self.type = "card" + String(Int.random(in: 2...14))
    }
    
    init(type: String) {
        self.type = type
    }
    
    init(isFaceUp: Bool) {
        self.type = "card" + String(Int.random(in: 2...14))
        self.isFaceUp = isFaceUp
    }
    
    init(DurationAndDelay: CGFloat) {
        self.type = "card" + String(Int.random(in: 2...14))
        self.DurationAndDelay = DurationAndDelay
    }
    
    init(type: String, isFaceUp: Bool) {
        self.type = type
        self.isFaceUp = isFaceUp
    }
    
    func getDurationAndDelay()-> CGFloat {
        return self.DurationAndDelay
    }
    
    func setDurationAndDelay(DurationAndDelay: CGFloat) {
        self.DurationAndDelay = DurationAndDelay
    }
    
    func flip() {
        self.isFaceUp = !self.isFaceUp
        
        if self.isFaceUp {
            withAnimation(.linear(duration: self.DurationAndDelay)) {
                self.backDegrees = 90.0
            }
            withAnimation(.linear(duration: self.DurationAndDelay).delay(self.DurationAndDelay)) {
                self.frontDegrees = 0.0
            }
        } else {
            withAnimation(.linear(duration: self.DurationAndDelay)) {
                self.frontDegrees = -90.0
            }
            withAnimation(.linear(duration: self.DurationAndDelay).delay(self.DurationAndDelay)) {
                self.backDegrees = 0.0
            }
        }
    }
    
    func randomizeCard() {
        self.type = "card" + String(Int.random(in: 2...14))
    }
    
}

class HandData: ObservableObject {
    @Published private var cards: [CardData]
    
    init() {
        @StateObject var card = CardData()
        self.cards = [card]
    }
    
    init(cards: [CardData]) {
        self.cards = cards
    }
    
    func at(index: Int)-> CardData {
        return cards[index]
    }
    
    func list()-> [CardData] {
        return cards
    }
    
    func addCard(cardData: CardData) {
        self.cards.append(cardData)
    }
    
    func removeCard(index: Int) {
        self.cards.remove(at: index)
    }
    
    func setDurationAndDelay(DurationAndDelay: CGFloat) {
        for card in cards {
            card.setDurationAndDelay(DurationAndDelay: DurationAndDelay)
        }
    }
}
