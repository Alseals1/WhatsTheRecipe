import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    public static let shared = AuthService()
    let db = Firestore.firestore()
    
    private init() {}
    
    
    /// A method to register the user
    /// - Parameters:
    ///   - user: The users info (firstname, lastname, email, password )
    ///   - completion: A completion with two values...
    ///   - Bool: wasRegistered - Determine if the user was register and save in the data base correctly
    ///   - Error: An optional error if firebase provides one
    
    public func signOut(completion: @escaping (Error?) -> Void) {
        
        do {
            try Auth.auth().signOut()
            completion(nil)
        }catch {
            completion(error)
        }
        
    }
}
