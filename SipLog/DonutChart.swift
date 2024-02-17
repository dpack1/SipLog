//
//  DonutChart.swift
//  SipLog
//
//  Created by Dylan Packham on 2/16/24.
//

import SwiftUI

struct DonutChart: View {
    var achieved: Int
    var goal: Int
    
    private var progress: Double {
        return Double(achieved) / Double(goal)
    }
    
    @State private var animatedProgress: Double = 0
    @State private var animatedLabel: Double = 0
    let animationDuration = 2.0

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.5), lineWidth: 20)
                .opacity(0.3)

            Circle()
                .trim(from: 0, to: CGFloat(min(animatedProgress, 1.0)))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .square))
                .rotationEffect(Angle(degrees: 220))
                .onAppear {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        animatedProgress = progress
                    }
                }

            VStack(spacing: 0) {
                Text("Calories")
                    .font(Font.custom("HelveticaNeue", size: 12))

                Text("\(achieved)")
                    .font(Font.custom("HelveticaNeue", size: 40))
                    .onAppear {
                        let numberOfSteps = Int(progress / 0.01)
                        let calculatedTimeInterval = animationDuration / Double(numberOfSteps)

                        Timer.scheduledTimer(withTimeInterval: calculatedTimeInterval, repeats: true) { timer in
                            animatedLabel += 0.01
                            if animatedLabel >= progress {
                                timer.invalidate()
                            }
                        }
                    }

                Text("out of \(goal)")
                    .font(Font.custom("HelveticaNeue", size: 12))
            }
        }
    }
}

struct DonutChart_Previews: PreviewProvider {
    static var previews: some View {
        DonutChart(achieved: 475, goal: 500)
            .frame(width: 100, height: 100)
    }
}
