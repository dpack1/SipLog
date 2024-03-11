//
//  CalorieChart.swift
//  SipLog
//
//  Created by Dylan Packham on 3/11/24.
//

import SwiftUI

struct CalorieChart: View {
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
        DonutChart(achieved: achieved, goal: goal, color: color, lineWidth: lineWidth)
            .overlay {
                VStack(spacing: 0) {
                    Text("Calories")
                        .font(Font.custom("HelveticaNeue", size: 12))
                    
                    Text("\(Int(animatedLabel * Double(achieved)))")
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

struct CalorieChart_Previews: PreviewProvider {
    static var previews: some View {
        CalorieChart(achieved: 475, goal: 500, color: "companyRed", lineWidth: 18)
            .frame(width: 100, height: 100)
    }
}
