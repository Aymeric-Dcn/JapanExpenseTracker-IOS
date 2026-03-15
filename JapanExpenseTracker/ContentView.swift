//
//  ContentView.swift
//  JapanExpenseTracker
//
//  Created by Aymeric Duchene on 15/03/2026.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Text("Japan Expense Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                NavigationLink("Ajouter une dépense") {
                    AddExpenseView()
                }
                
                NavigationLink("Ajouter un retrait cash") {
                    Text("Ecran retrait")
                }
                
                NavigationLink("Voir les dépenses") {
                    Text("Historique")
                }
                
                NavigationLink("Statistiques") {
                    Text("Stats")
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
