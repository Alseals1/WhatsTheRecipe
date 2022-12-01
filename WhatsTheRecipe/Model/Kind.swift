import Foundation

struct Kind: RawRepresentable, Hashable {
    typealias RawValue = String
    var rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    static let categories = Kind(rawValue: Section.AppSection.categories.rawValue)
    static let promotion = Kind(rawValue: Section.AppSection.promotion.rawValue)
    static let newestRecipe = Kind(rawValue: Section.AppSection.newestRecipe.rawValue)
}
