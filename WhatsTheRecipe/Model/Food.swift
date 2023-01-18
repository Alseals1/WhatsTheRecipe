import Foundation

struct Recipe: Hashable,Codable {
    var id: Int
    var type: String
    var category: String
    var title: String
    var ingredients: [String]
    var newestRecipe: Bool
    var chefs: [Chef]
    var image: String
}

struct Chef: Hashable, Codable {
    var id: Int
    var name: String
    var image: String
}
