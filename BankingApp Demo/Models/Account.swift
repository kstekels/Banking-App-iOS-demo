//
//  Account.swift
//  BankingApp Demo
//
//  Created by karlis.stekels on 28/04/2023.
//

import Foundation

enum AccountType: String, Codable, CaseIterable {
    case checking
    case savings
}

extension AccountType {
    var title: String {
        switch self {
        case .checking:
            return "checking"
        case .savings:
            return "savings"
        }
    }
}


struct Account: Decodable {
    let id: UUID
    let name: String
    let accountType: AccountType
    let balance: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case accountType = "accountType"
        case balance = "balance"
    }
}
