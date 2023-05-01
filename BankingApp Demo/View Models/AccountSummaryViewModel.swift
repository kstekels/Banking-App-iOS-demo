//
//  AccountSummaryViewModel.swift
//  BankingApp Demo
//
//  Created by karlis.stekels on 28/04/2023.
//

import Foundation

class AccountSummaryViewModel: ObservableObject {
    
    private var _accountModels = [Account]()
    
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    // Gives total amount of accounts
    var total: Double {
        _accountModels.map { $0.balance }.reduce(0, +)
    }
    
    func getAllAccounts() {
        
        AccountService.shared.getAllAccounts { result in
            switch result {
            case .success(let accounts):
                if let accounts = accounts {
                    DispatchQueue.main.async {
                        self._accountModels = accounts
                        // For Every account in accounts, we are calling initializer for account vm
                        self.accounts = accounts.map(AccountViewModel.init)
                    }
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}


class AccountViewModel {
    
    var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    var name: String {
        account.name
    }
    
    var accountID: String {
        account.id.uuidString
    }
    
    var accountType: String {
        account.accountType.title
    }
    
    var balance: Double {
        account.balance
    }
    
}
