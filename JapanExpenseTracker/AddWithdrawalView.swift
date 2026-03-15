//
//  AddWithdrawalView.swift
//  JapanExpenseTracker
//
//  Created by Aymeric Duchene on 15/03/2026.
//

import SwiftUI

struct AddWithdrawalView: View {
    
    @EnvironmentObject var manager: ExpenseManager
    @State private var amount = ""
    
    var body: some View {
        Form {
            TextField("Amount withdrawn (¥)", text: $amount)
                .keyboardType(.decimalPad)
            
            Button("Add Withdrawal") {
                if let value = Double(amount) {
                    manager.addWithdrawal(value)
                    amount = ""
                }
            }
            
            Text("Cash remaining: \(manager.cashRemaining, specifier: "%.0f") ¥ (\(manager.cashRemaining * 0.0062, specifier: "%.2f") €)")
                .padding()
                .font(.headline)
        }
        .navigationTitle("Cash Withdrawal")
    }
}
