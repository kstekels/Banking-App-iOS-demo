//
//  CreateAccountRequest.swift
//  BankingApp Demo
//
//  Created by Kārlis Štekels on 01/05/2023.
//

import Foundation

struct CreateAccountRequest: Codable {
    
    let name: String
    let accountType: String
    let balance: Double
    
}
