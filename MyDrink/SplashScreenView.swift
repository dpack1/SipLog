//
//  SplashScreenView.swift
//  MyDrink
//
//  Created by Dylan Packham on 9/18/23.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive  {
            ContentView()
        }
        else {
            VStack {
                VStack {
                    Image(systemName: "steam")
                    Image(systemName: "mug.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    
                    Text("SipLog")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(colorScheme == .dark ?.white.opacity(0.80) : .black.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
