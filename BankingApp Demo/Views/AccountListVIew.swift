//
//  AccountListVIew.swift
//  BankingApp Demo
//
//  Created by karlis.stekels on 28/04/2023.
//

import SwiftUI

struct AccountListVIew: View {
    
    let accounts: [AccountViewModel]
    
    var body: some View {
        List(accounts, id: \.accountID) { account in
            AccountCellView(account: account)
        }
        .listStyle(.plain)
    }
}

struct AccountListVIew_Previews: PreviewProvider {
    static var previews: some View {
        
        let account = Account(id: UUID(), name: "John Doe", accountType: .checking, balance: 200)
        let accountVM = AccountViewModel(account: account)
        
        return AccountListVIew(accounts: [accountVM])
    }
}

struct AccountCellView: View {
    
    let account: AccountViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(account.name)
                    .font(.headline)
                
                Text(account.accountType)
                    .opacity(0.5)
            }
            Spacer()
            Text("\(account.balance.formatAsCurrency())")
                .foregroundColor(Color.green)
        }
    }
}
