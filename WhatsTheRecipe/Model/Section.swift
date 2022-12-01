import Foundation


struct Section: Hashable {
    let id = UUID()
    
    let title: String
    let subtitle: String
    let kind: Kind
    let item: [Food]
    
    init(title: String = "", subtitle: String = "", kind: Kind, item: [Food]) {
        self.title = title
        self.subtitle = subtitle
        self.kind = kind
        self.item = item
    }
    
    enum AppSection: String {
        case categories
        case promotion
        case newestRecipe
    }
    
}
