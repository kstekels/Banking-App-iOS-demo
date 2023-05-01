//
//  TransferFundsViewModel.swift
//  BankingApp Demo
//
//  Created by Kārlis Štekels on 01/05/2023.
//

import Foundation

class TransferFundsViewModel: ObservableObject {
    
    var fromAccount: AccountViewModel?
    var toAccount: AccountViewModel?
    
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    func populateAccounts() {
        AccountService.shared.getAllAccounts { result in
            switch result {
                
            case .success(let accounts):
                if let accounts = accounts {
                    DispatchQueue.main.async {                   
                        self.accounts = accounts.map(AccountViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
