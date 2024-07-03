//
//  StartMenu.swift
//  21
//
//  Created by Zachary Hillman on 6/26/24.
//

import SwiftUI

private var flipTimer = Timer()
private var sequenceTimer = Timer()

struct StartMenu: View {
    @State var background = "background-plain"
    @State var settingsSheetActive = false
    
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
                Button(action: {
                    print("settings button pressed")
                    self.settingsSheetActive.toggle()
                }, label: {
                    Image("settings-button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                })
                .sheet(isPresented: $settingsSheetActive, content: {
                    SettingsSheetView(background: $background)
                })
                NavigationLink(destination: GameView(background: $background).onAppear {
                    flipTimer.invalidate()
                }) {
                    Image("start-button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                }
            }
            .padding()
            .shadow(radius: 8)
            .onAppear {
                flipSequentially()
                startTimer()
            }
            .background(
                Image(background)
                    .resizable()
                    .ignoresSafeArea()
        )
        }
    }
    
    private func startTimer() {
        flipTimer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { timer in
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
    
    func flipSequentially() {
        titleCards.at(index: 0).flip()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            titleCards.at(index: 1).flip()
        })
    }
    
    //
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
