//
//  AccountSummaryScreen.swift
//  BankingApp Demo
//
//  Created by karlis.stekels on 28/04/2023.
//

import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaaryVM = AccountSummaryViewModel()
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                    AccountListVIew(accounts: accountSummaaryVM.accounts)
                        .frame(height: reader.size.height / 2)
                    HStack{
                        Text("\(accountSummaaryVM.total.formatAsCurrency())")
                        Spacer()
                        Button {
                            accountSummaaryVM.getAllAccounts()
                        } label: {
                            Text("Refresh")
                        }.buttonStyle(.bordered)

                    }.padding(.horizontal)
                }
            }
        }
        .onAppear{
            accountSummaaryVM.getAllAccounts()
        }
        .navigationTitle("Account Summary")
        .embedInNavigationView()
    }
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
