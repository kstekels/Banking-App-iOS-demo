//
//  AccountService.swift
//  BankingApp Demo
//
//  Created by karlis.stekels on 28/04/2023.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
    case noData
}


class AccountService {
    // Only one instance can be created, that why private init is used and static shared
    private init() { }
    
    static let shared = AccountService()
    
    func createAccount(createAccountRequest: CreateAccountRequest, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) {
        
        guard let url = URL.urlForCreateAccounts() else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(createAccountRequest)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let createAccountResponse = try? JSONDecoder().decode(CreateAccountResponse.self, from: data)
            
            if let createAccountResponse = createAccountResponse {
                completion(.success(createAccountResponse))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
    
    func getAllAccounts(completion: @escaping (Result<[Account]?,NetworkError>) -> Void) {
        
        guard let url = URL.urlForAccounts() else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            print(url)
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let accounts = try? JSONDecoder().decode([Account].self, from: data)
            
            if accounts == nil {
                completion(.failure(.decodingError))
            } else {
                completion(.success(accounts))
            }
            
        }.resume()
        
    }
}
