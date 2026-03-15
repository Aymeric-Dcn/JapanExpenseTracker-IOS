//
//  ContentView.swift
//  JapanExpenseTracker
//
//  Created by Aymeric Duchene on 15/03/2026.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var manager: ExpenseManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Dashboard cash
                    VStack {
                        Text("Cash remaining: \(manager.cashRemaining, specifier: "%.0f") ¥")
                            .font(.title2)
                            .foregroundColor(manager.cashRemaining < 5000 ? .red : .primary)
                        Text("Total spent: \(manager.totalSpent, specifier: "%.0f") ¥")
                            .font(.subheadline)
                    }
                    .padding()
                    
                    // Title
                    Text("Japan Expense Tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    // Navigation Menusdé
                    NavigationLink("Add Expense") {
                        AddExpenseView()
                    }
                    
                    NavigationLink("Add Cash Withdrawal") {
                        AddWithdrawalView()
                    }
                    
                    NavigationLink("See Expenses") {
                        ExpenseListView()
                    }
                    
                    NavigationLink("Statistics") {
                        Text("Stats")
                    }
                    
                }
                .padding()
            }
        }
    }
}

