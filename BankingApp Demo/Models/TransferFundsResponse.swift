//
//  TransferFundsResponse.swift
//  BankingApp Demo
//
//  Created by Kārlis Štekels on 01/05/2023.
//

import Foundation

struct TransferFundResponse: Decodable {
    
    let success: Bool
    let error: String?
    
}
