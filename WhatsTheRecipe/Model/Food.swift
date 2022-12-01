import Foundation

struct Food: Hashable {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    let recipe: String
    
    init(title: String = "", description: String = "", image: String = "", recipe: String = "") {
        self.title = title
        self.description = description
        self.image = image
        self.recipe = recipe
    }
    
}
