//
//  DonutChart.swift
//  SipLog
//
//  Created by Dylan Packham on 2/16/24.
//

import SwiftUI

struct DonutChart: View {
    var progress: Double
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

            Text("\(Int(animatedLabel * 100))%")
                .font(.headline)
                .foregroundColor(.red)
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

        }
    }
}

struct DonutChart_Previews: PreviewProvider {
    static var previews: some View {
        DonutChart(progress: 0.75)
            .frame(width: 100, height: 100)
    }
}
