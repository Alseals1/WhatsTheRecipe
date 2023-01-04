import Foundation
import Combine
import UIKit

struct Constant {
    struct Path {
        static let categories = "/1/categories.php"
        static let meal = "/filter.php"
    }
}

struct ApiService {
    
    enum EndPoint {
        static var baseUrl = URL(string: "https://www.themealdb.com/api/json/v1")
        
        case meal(String)
        case categories
        
        var url: URL {
            switch self {
                case .categories:
                    return (EndPoint.baseUrl?.appending(path: Constant.Path.categories).appending("api_key", value: "1"))!
                case .meal(let value):
                    return (EndPoint.baseUrl?.appending(path: Constant.Path.meal).appending("c", value: value))!
                
            }
        }
        
        static func request(with url: URL) -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return request
        }
    }
    
   
}


extension URL {
    func appending(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
}
