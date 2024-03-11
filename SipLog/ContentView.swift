//
//  ContentView.swift
//  SipLog
//
//  Created by Dylan Packham on 4/26/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var menu = Menu()
    @StateObject var history = History()
    @State private var showingAddScreen = false
    
    @State private var animatedProgress: Double = 0
    @State private var animatedLabel: Double = 0
    var goal: Int = 500
    let animationDuration = 2.0
    
    
    
    private var progress: Double {
        return Double(totalCalories) / Double(goal)
    }
    
    var totalCaffeine: Int {
        history.servings.map(\.caffeine).reduce(0, +)
    }
    
    var totalCalories: Int {
        history.servings.map(\.calories).reduce(0, +)
    }
    
    var body: some View {
        NavigationStack{
            
            
            VStack {
                
                HStack {
                    VStack {
                        HStack {
                            
                            Text("SipLog")
                                .font(Font.custom("HelveticaNeue", size: 40))
                                .foregroundStyle(Color("companyRed"))
                            Spacer()
                        }
                        HStack {
                            Text(currentWeekString())
                                .font(Font.custom("HelveticaNeue", size: 20))
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        // Your other content here
                        NavigationLink(destination: MenuView().environmentObject(Menu())) {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                                .frame(width: 75, height: 32)
                                .foregroundColor(Color("companyGray").opacity(0.3))
                                .padding()
                                .overlay {
                                    HStack (spacing: 0){
                                        Image("MiniSplashLogo")
                                            .frame(width: 20)
                                        Text("Log + ")
                                            .font(Font.custom("HelveticaNeue", size: 16))
                                            .foregroundStyle(Color(.black))
                                    }
                                }
                        }
                    }
                    
                    
                }
                .padding(.leading)
                
                HStack {
                    CalorieChart(achieved: totalCalories, goal: 500, color: "companyRed", lineWidth: 18)
                        .frame(width: 143, height: 143)
                        .padding()
                }
                
                
                List {
                    Section("Weekly Summary") {
                        Text("Caffeine: \(totalCaffeine)mg")
                            .font(Font.custom("HelveticaNeue", size: 16))
                        
                        Text("Calories: \(totalCalories)")
                            .font(Font.custom("HelveticaNeue", size: 16))
                        
                    }
                    .font(Font.custom("HelveticaNeue", size: 12))
                    .foregroundStyle(.black)
                    .listRowBackground(Color("Light Gray"))
                    
                    
                    Section("Entries") {
                        if history.servings.isEmpty {
                            Button("Add your first drink!") {
                                showingAddScreen = true
                            }
                        } else {
                            
                            ForEach(history.servings) { serving in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(serving.name)
                                            .font(Font.custom("HelveticaNeue", size: 16))
                                        
                                        
                                        Text(serving.description)
                                            .font(Font.custom("HelveticaNeue", size: 12))
                                    }
                                    
                                    Spacer()
                                    
                                    Text ("\(serving.caffeine)mg")
                                }
                                .swipeActions {
                                    
                                    Button(role: .destructive) {
                                        withAnimation {
                                            history.delete(serving)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    
                                    Button {
                                        withAnimation {
                                            history.reorder(serving)
                                        }
                                    } label: {
                                        Label("Repeat", systemImage:"doc.on.doc")
                                    }
                                    .tint(.blue)
                                }
                            }
                        }
                    }
                    .font(Font.custom("HelveticaNeue", size: 12))
                    .foregroundStyle(.black)
                    .listRowBackground(Color("Light Gray"))
                }
                .scrollContentBackground(.hidden)
            }
        }
        .environmentObject(menu)
        .environmentObject(history)
    }
    
    private func currentWeekString() -> String {
        let calendar = Calendar.current
        let today = Date()
        
        if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)),
           let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd - "
            var currentWeek = dateFormatter.string(from: startOfWeek).trimmingCharacters(in: .whitespacesAndNewlines)
            dateFormatter.dateFormat = " MMMM dd"
            currentWeek += dateFormatter.string(from: endOfWeek).trimmingCharacters(in: .punctuationCharacters)
            
            return currentWeek
        }
        return "Unknown Week"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
