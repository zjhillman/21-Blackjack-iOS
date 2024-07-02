//
//  BlackJack.swift
//  21
//
//  Created by Zachary Hillman on 6/28/24.
//

import Foundation
import SwiftUI

class BlackJack: ObservableObject {
    private var isGameActive: Bool
    
    @Published private var playerCards: HandData
    @Published private var dealerCards: HandData
    @Published private var playerScore: Int
    @Published private var dealerScore: Int
    
    init() {
        isGameActive = true
        playerCards = HandData(cards: [
            CardData(DurationAndDelay: 0.20),
            CardData(DurationAndDelay: 0.20)
        ])
        dealerCards = HandData(cards: [
            CardData(DurationAndDelay: 0.15),
            CardData(DurationAndDelay: 0.15)
        ])
        playerScore = 0
        dealerScore = 0
    }
    
    func getPlayerCards()->HandData {
        return self.playerCards
    }
    
    func getDealerCards()->HandData {
        return self.dealerCards
    }
    
    func getPlayerScore()->Int {
        return self.playerScore
    }
    
    func getDealerScore()->Int {
        return self.dealerScore
    }
    
    func setPlayerCards(cards: HandData) {
        self.playerCards = cards
    }
    
    func setDealerCards(cards: HandData) {
        self.dealerCards = cards
    }
    
    func score() {
        self.playerScore = getHandScore(cards: playerCards)
        self.dealerScore = getHandScore(cards: dealerCards)
    }
    
    func getHandScore(cards: HandData)->Int {
        var score = 0
        var ace: Bool = false
        
        for card in cards.list() {
            switch card.type {
            case "card2":
                score += 2
            case "card3":
                score += 3
            case "card4":
                score += 4
            case "card5":
                score += 5
            case "card6":
                score += 6
            case "card7":
                score += 7
            case "card8":
                score += 8
            case "card9":
                score += 9
            case "card10":
                score += 10
            case "card11":
                score += 10
            case "card12":
                score += 10
            case "card13":
                score += 10
            case "card14":
                ace = true
                score += 1
            default:
                print("system failure D:")
                return score
            }
        }
        if ace && score <= 11 {
            score += 10
        }
        print("score: \(score)")
        return score
    }
    
    func hit() {
        if isGameActive {
            var card = CardData()
            playerCards.addCard(cardData: card)
            self.score()
        }
    }
    
    func dealerHit() {
        self.dealerCards.addCard(cardData: CardData())
        self.score()
    }
    
    func stand() {
        dealerTurn()
        gameEnd()
    }
    
    func dealerTurn() {
        while self.dealerScore < self.playerScore && self.dealerScore < 20 {
            dealerHit()
        }
    }
    
    func gameEnd() {
        isGameActive = false
        var message:String = "Game has ended. "
        if self.playerScore > self.dealerScore {
            message += "You have won, congratulations! "
        } else {
            message += "You got beat lol. "
        }
        message += "The score was \(playerScore) to \(dealerScore)"
        
        print(message)
    }
}

