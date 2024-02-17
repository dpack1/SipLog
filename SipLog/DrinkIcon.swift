//
//  DrinkIcon.swift
//  SipLog
//
//  Created by Dylan Packham on 2/17/24.
//

import SwiftUI

struct DrinkIcon: View {
    var body: some View {
        VStack {
            Cup()
                .stroke(.black, lineWidth: 0.5)
                .frame(width: 168/10, height: 177/10)
                .foregroundColor(.gray)
                .overlay {
                    Liquid()
                        .frame(width: 116/10 , height: 136/10)
                        .foregroundColor(.black)
                        .padding(.trailing, 1)
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

struct DrinkIcon_Previews: PreviewProvider {
    static var previews: some View {
        DrinkIcon()
            .frame(width: 100, height: 100)
    }
}
