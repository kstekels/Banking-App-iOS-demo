//
//  AccountSummaryScreen.swift
//  BankingApp Demo
//
//  Created by karlis.stekels on 28/04/2023.
//

import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaaryVM = AccountSummaryViewModel()
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                    AccountListVIew(accounts: accountSummaaryVM.accounts)
                    //                        .frame(height: reader.size.height / 2)
                    Text("\(accountSummaaryVM.total.formatAsCurrency())")
                }
            }
        }
        .onAppear{
            accountSummaaryVM.getAllAccounts()
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            accountSummaaryVM.getAllAccounts()
        }, content: {
            AddAccountScreen()
        })
        .navigationBarItems(trailing: Button("Add Account") {
            self.isPresented = true
        })
        .navigationTitle("Account Summary")
        .embedInNavigationView()
    }
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
