//
//  CardFlipAnimation.swift
//  21
//
//  Created by Zachary Hillman on 6/25/24.
//

import SwiftUI

struct CardFlipAnimation: View {
    @State var backDegree = -90.0
    @State var frontDegree = 0.0
    @State var isFlipped = false
    
    let width: CGFloat = 200
    let height: CGFloat = 250
    let DurationAndDelay: CGFloat = 0.15
    
    func flipCard() {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation (.linear(duration: DurationAndDelay)) {
                backDegree = 90
            }
            withAnimation (.linear(duration: DurationAndDelay).delay(DurationAndDelay)) {
                frontDegree = 0
            }
        } else {
            withAnimation (.linear(duration: DurationAndDelay)) {
                frontDegree = -90
            }
            withAnimation (.linear(duration: DurationAndDelay).delay(DurationAndDelay)) {
                backDegree = 0
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            Image("background-wood-grain")
                .resizable()
                .ignoresSafeArea()
            
            ZStack {
                Image("back")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 1.0, y: 0.0, z: 0.0))
                Image("card13")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 1.0, y: 0.0, z: 0.0))
            }
            .onTapGesture {
                flipCard()
            }
        }
    }
}

#Preview {
    CardFlipAnimation()
}
