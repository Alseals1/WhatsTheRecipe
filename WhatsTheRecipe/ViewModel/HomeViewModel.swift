import Foundation
import UIKit
import FirebaseAuth


struct HomeViewModel {
    
    static func fetchCategoies(completion: @escaping([Category]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: ApiService.EndPoint.request(with: ApiService.EndPoint.categories.url)) { data, response, error in
            DispatchQueue.main.async {
                if error != nil,
                   let response = response as? HTTPURLResponse,
                   response.statusCode == 200 && response.statusCode < 300 { return }
                
                
                guard let data = data else {
                    print("Error getting data")
                    return
                    
                }
                
                do {
                    let categories = try JSONDecoder().decode(MealCategories.self, from: data)
                    completion(categories.categories, nil)
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
            
        }.resume()
    }
}
