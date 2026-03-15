import Foundation
import Combine

class ExpenseManager: ObservableObject {
    
    @Published var expenses: [Expense] = [] {
        didSet { saveExpenses() }
    }
    
    @Published var categories: [String] = []
    
    @Published var withdrawals: [Double] = [] {
        didSet { saveWithdrawals() }
    }
    
    private let expensesPath = FileManager.documentsDirectory.appendingPathComponent("expenses.json")
    private let withdrawalsPath = FileManager.documentsDirectory.appendingPathComponent("withdrawals.json")
    
    init() {
        loadExpenses()
        loadWithdrawals()
        categories = Array(Set(expenses.map { $0.category }))
    }
    
    // MARK: - Expenses
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        if !categories.contains(expense.category) {
            categories.append(expense.category)
        }
    }
    
    var cashSpent: Double {
        expenses
            .filter { $0.paymentMethod == "Cash" }
            .reduce(0) { $0 + $1.amountYen }
    }
    
    var totalSpent: Double {
        expenses.reduce(0) { $0 + $1.amountYen }
    }
    
    // MARK: - Withdrawals
    func addWithdrawal(_ amount: Double) {
        withdrawals.append(amount)
    }
    
    var cashRemaining: Double {
        withdrawals.reduce(0, +) - cashSpent
    }
    
    // MARK: - Save / Load
    func saveExpenses() {
        do {
            let data = try JSONEncoder().encode(expenses)
            try data.write(to: expensesPath)
        } catch {
            print("Saving expenses error: \(error)")
        }
    }
    
    func loadExpenses() {
        do {
            let data = try Data(contentsOf: expensesPath)
            expenses = try JSONDecoder().decode([Expense].self, from: data)
        } catch {
            expenses = []
        }
    }
    
    func saveWithdrawals() {
        do {
            let data = try JSONEncoder().encode(withdrawals)
            try data.write(to: withdrawalsPath)
        } catch {
            print("Saving withdrawals error: \(error)")
        }
    }
    
    func loadWithdrawals() {
        do {
            let data = try Data(contentsOf: withdrawalsPath)
            withdrawals = try JSONDecoder().decode([Double].self, from: data)
        } catch {
            withdrawals = []
        }
    }
    var weeklyExpenses: [Date: [Expense]] {
        Dictionary(grouping: expenses) { $0.date.startOfWeek() ?? $0.date }
    }

    func expenses(forWeekOf date: Date, category: String? = nil) -> [Expense] {
        let weekStart = date.startOfWeek() ?? date
        var weekExpenses = weeklyExpenses[weekStart] ?? []
        if let category = category, !category.isEmpty {
            weekExpenses = weekExpenses.filter { $0.category == category }
        }
        return weekExpenses
    }

    func totalForWeek(of date: Date, category: String? = nil) -> Double {
        expenses(forWeekOf: date, category: category)
            .reduce(0) { $0 + $1.amountYen }
    }
}

