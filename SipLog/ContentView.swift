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
                            .foregroundStyle(Color(.red))
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
                        NavigationLink(destination: MenuView()) {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 75, height: 32)
                                .foregroundColor(Color("textColor").opacity(0.3))
                                .padding()
                                .overlay {
                                    HStack (spacing: 0){
                                        DrinkIcon()
                                            .padding([.leading, .top], 5)
                                        Text("Log + ")
                                            .font(Font.custom("HelveticaNeue", size: 16))
                                            .foregroundStyle(Color("textColor").opacity(0.6))
                                    }
                                }
                        }
                    }


            }
            .padding(.leading)

//            DonutChart(progress: Double(totalCaffeine) / 100.0)
            DonutChart(achieved: 375, goal: 500)
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
