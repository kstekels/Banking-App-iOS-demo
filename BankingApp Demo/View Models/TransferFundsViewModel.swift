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
    @Published var message: String?
    
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    var amount: String = ""
    
    var isAmountValid: Bool {
        guard let userAmount = Double(amount) else {
            return false
        }
        return userAmount <= 0 ? false : true
    }
    
    var filteredAccounts: [AccountViewModel] {
        if self.fromAccount == nil {
            return accounts
        } else {
            return accounts.filter {
                
                guard let fromAccount = self.fromAccount else {
                    return false
                }
                
                return $0.accountID != fromAccount.accountID
                
            }
        }
    }
    
    
    var fromAccounType: String {
        fromAccount != nil ? fromAccount!.accountType : ""
    }
    
    var toAccounType: String {
        toAccount != nil ? toAccount!.accountType : ""
    }
    
    private func isValid() -> Bool {
        return isAmountValid
    }
    
    func submitTransfer() {
        
        if isValid() {
            return
        }
        
        guard let fromAccount = fromAccount,
              let toAccount = toAccount,
              let amount = Double(amount)
        else {
            return
        }
        
        let transferFundRequest = TransferFundRequest(accountFromId: fromAccount.accountID.lowercased(), accountToId: toAccount.accountID.lowercased(), amount: amount)
        
        AccountService.shared.transferFunds(transferFundRequest: transferFundRequest) { result in
            switch result{
            case .success(let response):
                print(response)
            case .failure(let error):
                self.message = error.localizedDescription
            }
        }
        
    }
    
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
