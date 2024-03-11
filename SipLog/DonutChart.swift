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
    var color: String
    var lineWidth: Int
    
    private var progress: Double {
        return Double(achieved) / Double(goal)
    }
    
    @State private var animatedProgress: Double = 0
    @State private var animatedLabel: Double = 0
    let animationDuration = 2.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.5), lineWidth: Double(lineWidth))
                .opacity(0.3)
            
            Circle()
                .trim(from: 0, to: CGFloat(min(animatedProgress, 1.0)))
                .stroke(Color(color), style: StrokeStyle(lineWidth: Double(lineWidth), lineCap: .square))
                .rotationEffect(Angle(degrees: 220))
                .onAppear {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        animatedProgress = progress
                    }
                }
        }
    }
}

struct DonutChart_Previews: PreviewProvider {
    static var previews: some View {
        DonutChart(achieved: 475, goal: 500, color: "companyRed", lineWidth: 18)
            .frame(width: 100, height: 100)
    }
}
