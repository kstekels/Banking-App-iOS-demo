import Foundation

extension URL {
    
    static func urlForAccounts() -> URL? {
         return URL(string: "http://127.0.0.1:3000/api/accounts")
    }
    
    static func urlForCreateAccounts() -> URL? {
        return URL(string: "http://127.0.0.1:3000/api/accounts")
    }
}
