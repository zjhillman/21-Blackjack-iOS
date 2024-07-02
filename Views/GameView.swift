//
//  GameView.swift
//  21
//
//  Created by Zachary Hillman on 6/26/24.
//

import SwiftUI

struct GameView: View {

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
                .onAppear {
                    flipDealerCards()
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
            }, label: {
                Image("stand-button")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            })
            .frame(width: 350)
        }
        .padding()
        .background(Image("background-cloth")
            .resizable()
            .ignoresSafeArea()
        )
    }
    
    func flipDealerCards() {
        //wait to flip cards until view has taken fullscreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            
            for card in blackjack.getDealerCards().list() {
                card.flip()
            }
        })
        blackjack.score()
    }
}

#Preview {
    GameView()
}

