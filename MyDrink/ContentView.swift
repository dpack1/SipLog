//
//  ContentView.swift
//  MyDrink
//
//  Created by Dylan Packham on 4/26/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var menu = Menu()
    
    var body: some View {
        VStack {
            MenuView()
                .environmentObject(menu)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
