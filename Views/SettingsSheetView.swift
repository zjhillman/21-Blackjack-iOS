//
//  SettingsSheetView.swift
//  21
//
//  Created by Zachary Hillman on 7/2/24.
//

import SwiftUI

struct SettingsSheetView: View {
    @Binding var background: String
    
    var body: some View {
        VStack {
            Spacer()
            Text("What would you like to make the background?")
                .padding(.bottom)
            
            HStack {
                Spacer()
                Button("Plain") {
                    self.setBGPlain()
                }
                Spacer()
                Button("Cloth") {
                    self.setBGCloth()
                }
                Spacer()
                Button("Wood Cartoon") {
                    self.setBGWoodCartoon()
                }
                Spacer()
                Button("Wood Grain") {
                    self.setBGWoodGrain()
                }
                Spacer()
            }
            .padding(.top)
            Spacer()
            
        }
        .padding()
        .background(Color(.systemGray6)
            .ignoresSafeArea())
    }
    
    func setBGPlain() {
        self.background = "background-plain"
    }
    
    func setBGCloth() {
        self.background = "background-cloth"
    }
    
    func setBGWoodCartoon() {
        self.background = "background-wood-cartoon"
    }
    
    func setBGWoodGrain() {
        self.background = "background-wood-grain"
    }
}

#Preview {
    struct Preview: View {
        @State var bg = "background-plain"
        var body: some View {
            SettingsSheetView(background: $bg)
        }
    }
    
    return Preview()
}
