//
//  SplashScreenView.swift
//  SipLog
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
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                VStack {
                    VStack {
                            Circle()
                                .frame(width: 236 , height: 236)
                                .foregroundColor(Color("strawColor"))
                                .padding(.top, 100)
                                .overlay {
                                    Image("SplashLogo")
                                        .padding(.top, 20 )
                                        .padding(.trailing, 20)
                                        .shadow(radius: 5, x: 2, y: 3)

                                }




                        
                        Text("SipLog")
                            .font(Font.custom("HelveticaNeue", size: 72))
                            .foregroundColor(Color("companyRed"))
                        
                        Spacer()
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.smooth(extraBounce: 0.5)) {
                            
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                
        }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
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


