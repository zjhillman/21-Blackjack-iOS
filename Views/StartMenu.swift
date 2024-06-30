//
//  StartMenu.swift
//  21
//
//  Created by Zachary Hillman on 6/26/24.
//

import SwiftUI

private var flipTimer = Timer()

struct StartMenu: View {
    @StateObject var titleCards = HandData(cards: [
        CardData(),
        CardData()
    ])

    var body: some View {
        NavigationView {
            VStack{
                Text("21")
                    .font(.system(size: 80, design: .serif))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                PlayingHandView(handData: titleCards)
                    .offset(y: -50)
                Spacer()
                NavigationLink(destination: GameView()) {
                    Image("start-button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .offset(y: 30)
                }
                .onTapGesture {
                    stopTimer()
                }
//                Button(action: {
//                    print("You are adopted")
//                }, label: {
//                    Image("start-button")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                       .padding()
//                })
//               .offset(y: 40)
                
            }
            .padding()
            .shadow(radius: 8)
            .onAppear {
                startTimer()
            }
            .background(
                Image("background-plain")
                    .resizable()
                    .ignoresSafeArea()
        )
        }
    }
    
    private func startTimer() {
        flipTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            print("Timer Fired")
            
            let random = Int.random(in: 0..<titleCards.list().count)
            titleCards.at(index: random).flip()
            
            // randomize card if face down, waits for twice the value of CardData.DurationAndDelay to randomize the card after any animation will have finished
            DispatchQueue.main.asyncAfter(deadline: .now() + (titleCards.at(index: random).getDurationAndDelay() * 2), execute: {
                
                for card in titleCards.list() {
                    if !card.isFaceUp {
                        card.randomizeCard()
                    }
                }
            })
        }
    }
    
    // timer never stopped because timer var is in a different scope
    private func stopTimer() {
        flipTimer.invalidate()
    }
}

#Preview {
    StartMenu()
}

struct NavigationButton<Destination: View, Label: View> {
    var action: ()->Void = {}
    var destination: ()->Destination
    var label: ()->Label
    var codable: any Hashable
    
    @State private var isActive: Bool = false
    
    var body: some View {
        Button {
            self.action()
            self.isActive.toggle()
        } label: {
            self.label()
            NavigationLink(value: codable, label: self.label).navigationDestination(isPresented: $isActive, destination: self.destination)
        }
    }
}
