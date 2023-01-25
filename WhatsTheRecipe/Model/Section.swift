import Foundation

enum Section: Int {
    case category
    
    var sectionTitle: String? {
        switch self {
            case .category: return "Category"
        }
    }
}
