import Foundation

struct MealCategories: Codable {
    var categories: [Category]
}

struct Category: Identifiable, Codable {
    let id: String
    let category: String
    let description: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case category = "strCategory"
        case description = "strCategoryDescription"
    }
}

struct Meals: Codable {
    var meals: [Meal]
}

struct Meal: Identifiable, Codable {
    let id: String
    let mealImage: String
    let meal: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case mealImage = "strMealThumb"
        case meal = "strMeal"
    }
    
}
