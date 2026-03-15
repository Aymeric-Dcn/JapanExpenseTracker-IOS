//
//  AddExpenseView.swift
//  JapanExpenseTracker
//
//  Created by Aymeric Duchene on 15/03/2026.
//

import SwiftUI

struct AddExpenseView: View {
    
    @State private var amount = ""
    @State private var category = ""
    @State private var paymentMethod = "Cash"
    
    let methods = ["Cash","Card"]
    
    var body: some View {
        
        Form {
            
            TextField("Montant en yen", text: $amount)
                .keyboardType(.numberPad)
            
            TextField("Catégorie", text: $category)
            
            Picker("Paiement", selection: $paymentMethod) {
                ForEach(methods, id: \.self) {
                    Text($0)
                }
            }
            
            Button("Ajouter dépense") {
                print("Dépense ajoutée")
            }
            
        }
        .navigationTitle("Nouvelle dépense")
    }
}

#Preview {
    AddExpenseView()
}
