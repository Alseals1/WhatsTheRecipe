import Foundation

struct User: Codable {
    let id: String
    
    var firstname: String
    var lastname: String
    var email: String
    var password: String
}
