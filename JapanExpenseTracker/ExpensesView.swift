//
//  ExpensesView.swift
//  JapanExpenseTracker
//
//  Created by Aymeric Duchene on 15/03/2026.
//

import SwiftUI

struct ExpensesView: View {
    
    @EnvironmentObject var manager: ExpenseManager
    @State private var selectedPeriod = "Day"
    @State private var selectedCategory = "All"
    @State private var selectedPaymentMethod = "All"
    @State private var useEuro = false
    
    let periods = ["Day", "Week", "Month", "Total"]
    let paymentMethods = ["All", "Cash", "Card"]
    
    var categories: [String] { ["All"] + manager.categories }
    
    func filterExpenses(_ expenses: [Expense]) -> [Expense] {
        var filtered = expenses
        if selectedCategory != "All" { filtered = filtered.filter { $0.category == selectedCategory } }
        if selectedPaymentMethod != "All" { filtered = filtered.filter { $0.paymentMethod == selectedPaymentMethod } }
        return filtered
    }
    
    func expensesForSelectedPeriod() -> [Expense] {
        let now = Date()
        let calendar = Calendar.current
        switch selectedPeriod {
        case "Day":
            return filterExpenses(manager.expenses.filter { calendar.isDateInToday($0.date) })
        case "Week":
            return filterExpenses(manager.expenses(forWeekOf: now))
        case "Month":
            return filterExpenses(manager.expenses.filter { calendar.component(.month, from: $0.date) == calendar.component(.month, from: now) })
        default: // Total
            return filterExpenses(manager.expenses)
        }
    }
    
    func formatAmount(_ amount: Double) -> String {
        let value = useEuro ? amount * 0.0062 : amount
        let symbol = useEuro ? "€" : "¥"
        return String(format: "%.2f %@", value, symbol)
    }
    
    var body: some View {
        VStack(spacing: 15) {
            
            
            HStack {
                Picker("Period", selection: $selectedPeriod) {
                    ForEach(periods, id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)
                
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
            }
            HStack {
                Picker("Payment", selection: $selectedPaymentMethod) {
                    ForEach(paymentMethods, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                Toggle("Euro", isOn: $useEuro)
            }
            .padding(.horizontal)
            let expenses = expensesForSelectedPeriod()
            let maxAmount = expenses.map { $0.amountYen }.max() ?? 1
            let maxHeight: CGFloat = 150 // hauteur max pour une barre

            ScrollView(.horizontal) {
                HStack(alignment: .bottom, spacing: 10) {
                    ForEach(expenses) { expense in
                        VStack {
                            // Texte au-dessus des barres
                            Text(formatAmount(expense.amountYen))
                                .font(.caption2)
                                .rotationEffect(.degrees(-45))
                                .frame(height: 20)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5) // réduit le texte si trop long
                            
                            // Barre proportionnelle
                            Rectangle()
                                .fill(expense.paymentMethod == "Cash" ? Color.green : Color.purple)
                                .frame(width: 25,
                                       height: CGFloat(expense.amountYen / maxAmount) * maxHeight) // <-- normalisation
                                .cornerRadius(4)
                        }
                    }
                }
                .padding(.horizontal)
            }

            
            List(expensesForSelectedPeriod()) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.category).bold()
                        Text(expense.note).font(.caption).foregroundColor(.gray)
                    }
                    Spacer()
                    Text(formatAmount(expense.amountYen))
                        .foregroundColor(expense.paymentMethod == "Cash" ? .green : .purple)
                }
            }
            
            Text("Total: \(formatAmount(expensesForSelectedPeriod().reduce(0) { $0 + $1.amountYen }))")
                .font(.headline)
                .padding()
        }
        .navigationTitle("Expenses")
    }
}
