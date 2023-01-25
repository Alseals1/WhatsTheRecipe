import Foundation

struct Category: Hashable, Codable {
    var id: Int
    var type: String
    var category: String
    var title: String
    var chefs: [Chef]
    var image: String
}

struct Chef: Hashable, Codable {
    var id: Int
    var name: String
    var image: String
}
