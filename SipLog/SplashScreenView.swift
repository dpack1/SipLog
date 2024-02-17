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
                Color.orange
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Circle()
                            .frame(width: 250 , height: 250)
                            .foregroundColor(.black.opacity(0.5))
                            .overlay {
                                Cup()
                                    .frame(width: 168, height: 177)
                                    .rotationEffect(.degrees(-10.0))
                                    .foregroundColor(.blue)
                                    .overlay {
                                        Liquid()
                                            .frame(width: 116 , height: 136)
                                            .rotationEffect(.degrees(-10.0))
                                            .foregroundColor(.black)
                                            .padding(.trailing, 5)
                                    }
                                    .padding(.bottom, 85)
                            }
                            .padding(.top, 100)
                        
                        Text("SipLog")
                            .font(Font.custom("HelveticaNeue", size: 72))
                            .foregroundColor(colorScheme == .dark ?.white.opacity(0.80) : .white)
                        
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
    
    struct Cup: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0, y: 0))
            path.addCurve(to: CGPoint(x: 0.18249*width, y: 0.8699*height), control1: CGPoint(x: 0.1766*width, y: 0.859*height), control2: CGPoint(x: 0.18249*width, y: 0.8699*height))
            path.addLine(to: CGPoint(x: 0.7056*width, y: 0.8699*height))
            path.addLine(to: CGPoint(x: 0.85629*width, y: 0))
            path.closeSubpath()
            return path
        }
    }

    struct Straw: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: -2.48483*width, y: 0.66669*height))
            path.addLine(to: CGPoint(x: -2.3903*width, y: 0.32164*height))
            path.addLine(to: CGPoint(x: -1.66857*width, y: 0.82771*height))
            path.addLine(to: CGPoint(x: -1.71397*width, y: 0.92844*height))
            path.addLine(to: CGPoint(x: -2.30944*width, y: 0.49804*height))
            path.addLine(to: CGPoint(x: -2.3608*width, y: 0.66669*height))
            path.addLine(to: CGPoint(x: -2.48485*width, y: 0.66669*height))
            path.closeSubpath()
            return path
        }
    }


    struct Liquid: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0, y: 0))
            path.addCurve(to: CGPoint(x: 0.18572*width, y: 0.87588*height), control1: CGPoint(x: 0.1797*width, y: 0.8649*height), control2: CGPoint(x: 0.18572*width, y: 0.87588*height))
            path.addLine(to: CGPoint(x: 0.71809*width, y: 0.87588*height))
            path.addLine(to: CGPoint(x: 0.83479*width, y: 0.20345*height))
            path.closeSubpath()
            return path
        }
    }

}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}


