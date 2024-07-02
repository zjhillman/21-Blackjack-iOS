//
//  PlayingHandView.swift
//  21
//
//  Created by Zachary Hillman on 6/28/24.
//

import SwiftUI

struct PlayingHandView: View {
    @ObservedObject var handData: HandData
    
    var body: some View {
        HStack{
            ForEach(handData.list()) { card in
                PlayingCardView(cardData: card)
            }
        }
    }
}

#Preview {
    PlayingHandView(handData: HandData(cards: [
        CardData(isFaceUp: true),
        CardData(isFaceUp: true)
    ]))
}
