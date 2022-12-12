import Foundation

struct Food: Hashable {
    let id = UUID()
    let title: String
    let typeOfFood: String
    let chefName: String
    let description: String
    let image: String
    let recipe: String
    
    init(title: String = "", typeOfFood: String = "", chefName: String = "" ,description: String = "", image: String = "", recipe: String = "") {
        self.title = title
        self.typeOfFood = typeOfFood
        self.chefName = chefName
        self.description = description
        self.image = image
        self.recipe = recipe
    }
}
