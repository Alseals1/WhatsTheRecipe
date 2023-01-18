import Foundation

struct Kind: RawRepresentable, Hashable {
    typealias RawValue = String
    var rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
   
}
