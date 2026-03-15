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
                VStack(spacing: 30) {
                    
                    // Dashboard cash / total
                    VStack(spacing: 10) {
                        Text("Cash remaining")
                            .font(.headline)
                        Text("\(manager.cashRemaining, specifier: "%.0f") ¥")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(manager.cashRemaining < 5000 ? .red : .green)
                        
                        Text("Total spent")
                            .font(.headline)
                        Text("\(manager.totalSpent, specifier: "%.0f") ¥")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray6)))
                    .shadow(radius: 3)
                    
                    // Title
                    Text("Japan Expense Tracker")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 10)
                    
                    // Navigation menu
                    VStack(spacing: 15) {
                        NavigationLink(destination: AddExpenseView()) {
                            MenuButton(title: "Add Expense", color: .blue)
                        }
                        NavigationLink(destination: AddWithdrawalView()) {
                            MenuButton(title: "Add Cash Withdrawal", color: .orange)
                        }
//                        NavigationLink(destination: WeeklyExpensesView()) {
//                            MenuButton(title: "Weekly Expenses", color: .purple)
//                        }
//                        NavigationLink(destination: StatsView()) {
//                            MenuButton(title: "Statistics", color: .green)
//                        }
                        NavigationLink(destination: ExpensesView()){
                            MenuButton(title: "Expenses", color: .pink)
                        }
                    }
                }
                .padding()
            }
            
        }
    }
}

struct MenuButton: View {
    let title: String
    let color: Color
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(color))
            .shadow(radius: 2)
    }
}
