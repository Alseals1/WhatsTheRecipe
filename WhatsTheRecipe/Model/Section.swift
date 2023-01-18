import Foundation

struct Section: Hashable, Codable {
    let id: Int
    
    let title: String
    let kind: String
    let recipes: [Recipe]
}
