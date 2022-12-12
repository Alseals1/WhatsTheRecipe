import Foundation

struct Kind: RawRepresentable, Hashable {
    typealias RawValue = String
    var rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static let profileInfo = Kind(rawValue: Section.AppSection.profileInfo.rawValue)
    static let categories = Kind(rawValue: Section.AppSection.categories.rawValue)
    static let promotion = Kind(rawValue: Section.AppSection.promotion.rawValue)
    static let newestRecipe = Kind(rawValue: Section.AppSection.newestRecipe.rawValue)
    static let ingredient = Kind(rawValue: Section.AppSection.ingredient.rawValue)
    static let cookingTime = Kind(rawValue: Section.AppSection.cookingTime.rawValue)
    static let cookDetail = Kind(rawValue: Section.AppSection.cookDetail.rawValue)
}
