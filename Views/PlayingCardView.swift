//
//  PlayingCard.swift
//  21
//
//  Created by Zachary Hillman on 6/26/24.
//

import SwiftUI

struct PlayingCardView: View  {
    @ObservedObject var cardData: CardData
    
    var body: some View {
        ZStack {
            Image(cardData.type)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotation3DEffect(Angle(degrees: cardData.frontDegrees),
                                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                )
            Image("back")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotation3DEffect(Angle(degrees: cardData.backDegrees),
                                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                )
            
        }.onTapGesture {
            flipCard()
        }
    }
    
    func flipCard() {
        cardData.isFaceUp = !cardData.isFaceUp
        print("Card should be flipped, card is face up: \(cardData.isFaceUp)")
        if cardData.isFaceUp {
            withAnimation(.linear(duration: cardData.getDurationAndDelay())) {
                cardData.backDegrees = 90.0
            }
            withAnimation(.linear(duration: cardData.getDurationAndDelay()).delay(cardData.getDurationAndDelay())) {
                cardData.frontDegrees = 0.0
            }
        } else {
            withAnimation(.linear(duration: cardData.getDurationAndDelay())) {
                cardData.frontDegrees = -90.0
            }
            withAnimation(.linear(duration: cardData.getDurationAndDelay()).delay(cardData.getDurationAndDelay())) {
                cardData.backDegrees = 0.0
            }
        }
    }
}


#Preview {
    PlayingCardView(cardData: CardData())
}
