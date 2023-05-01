//
//  AccountSummaryScreen.swift
//  BankingApp Demo
//
//  Created by karlis.stekels on 28/04/2023.
//

import SwiftUI

enum ActiveSheet {
    case addAccount
    case transferFunds
}

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaaryVM = AccountSummaryViewModel()
    @State private var isPresented: Bool = false
    @State private var activeSheet: ActiveSheet = .addAccount
    
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                    AccountListVIew(accounts: accountSummaaryVM.accounts)
                    //                        .frame(height: reader.size.height / 2)
                    Text("\(accountSummaaryVM.total.formatAsCurrency())")
                    Button {
                        //
                    } label: {
                        Button {
                            self.activeSheet = .transferFunds
                            self.isPresented = true
                        } label: {
                            Text("Transfer funds")
                        }

                    }

                }
            }
        }
        .onAppear{
            accountSummaaryVM.getAllAccounts()
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            accountSummaaryVM.getAllAccounts()
        }, content: {
            
            if self.activeSheet == .transferFunds {
                TransferFundsScreen()
            } else if self.activeSheet == .addAccount {
                AddAccountScreen()
            }
            
        })
        .navigationBarItems(trailing: Button("Add Account") {
            self.activeSheet = .addAccount
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
