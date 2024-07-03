//
//  GameView.swift
//  21
//
//  Created by Zachary Hillman on 6/26/24.
//

import SwiftUI

struct GameView: View {
    @Binding var background: String

    @ObservedObject private var blackjack = BlackJack()
        
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Dealer: " + String(blackjack.getDealerScore()))
                    .font(.subheadline)
                .foregroundColor(.white)
                Spacer()
            }
            PlayingHandView(handData: blackjack.getDealerCards())
                .frame(height: 270)
                .onAppear {
                    flipDealerCardsOnViewOpen()
                    blackjack.score()
                }
            Spacer()
            HStack {
                Text("You: " + String(blackjack.getPlayerScore()))
                    .font(.subheadline)
                .foregroundColor(.white)
                Spacer()
            }
            PlayingHandView(handData: blackjack.getPlayerCards())
                .frame(height: 270)
            Spacer()
            
            Button(action: {
                blackjack.hit()
            }, label: {
                Image("hit-me-button")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            })
            .frame(width: 350)
            Button(action: {
                blackjack.stand()
                flipCards()
            }, label: {
                Image("stand-button")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            })
            .frame(width: 350)
        }
        .shadow(radius: 10)
        .padding()
        .background(Image(self.background)
            .resizable()
            .ignoresSafeArea()
        )
    }
    
    func flipDealerCardsOnViewOpen() {
        //wait to flip cards until view has taken fullscreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            
            for card in blackjack.getDealerCards().list() {
                if card.isFaceUp {
                    continue
                } else {
                    card.flip()
                }
            }
        })
        blackjack.score()
    }
    
    func flipCards() {
        for card in blackjack.getDealerCards().list() {
            if card.isFaceUp {
                continue
            } else {
                card.flip()
            }
        }
        for card in blackjack.getPlayerCards().list() {
            if card.isFaceUp {
                continue
            } else {
                card.flip()
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var background = "background-plain"
        var body: some View {
            GameView(background: $background)
        }
    }
    
    return Preview()
}

