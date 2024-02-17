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
    
    var totalCaffeine: Int {
        history.servings.map(\.caffeine).reduce(0, +)
    }
    
    var totalCalories: Int {
        history.servings.map(\.calories).reduce(0, +)
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                VStack {
                    HStack {
                        
                        Text("SipLog")
                            .font(Font.custom("HelveticaNeue", size: 40))
                            .foregroundStyle(.black.opacity(0.6))
                        Spacer()
                    }
                    HStack {
                        Text("February 11 - Febuary 17")
                            .font(Font.custom("HelveticaNeue", size: 20))

                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 75, height:32)
                    .foregroundColor(.black.opacity(0.3))
                    .padding()
                    .overlay {
                        HStack {
                            Text("Log +")
                                .font(Font.custom("HelveticaNeue", size: 16))
                                .foregroundStyle(.black.opacity(0.6))
                                .padding(.leading, 0)

                        }
                        
                    }
            }
            .padding(.leading)

            DonutChart(progress: Double(totalCaffeine) / 100.0)
                .frame(width: 143, height: 143)
                .padding()
            
            
            NavigationView {
                List {
                    if history.servings.isEmpty {
                        Button("Add your first drink!") {
                            showingAddScreen = true
                        }
                    } else {
                        
                        Section("Summary") {
                            Text("Caffeine: \(totalCaffeine)mg")
                            Text("Calories: \(totalCalories)")
                        }
                        ForEach(history.servings) {serving in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(serving.name)
                                        .font(.headline)
                                    
                                    Text(serving.description)
                                        .font(.caption)
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
                                    Label("Repeat", systemImage:"repeat")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen, content: MenuView.init)
                .toolbar {
                    Button {
                        showingAddScreen = true
                    } label: {
                        Label("Add New Drink", systemImage: "plus")
                    }
                }
            }
            .environmentObject(menu)
            .environmentObject(history)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
