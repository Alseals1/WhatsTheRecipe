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
    public func registerUser(with user: User, completion: @escaping (Bool, Error?) -> Void) {
        let firstname = user.firstname
        let lastname = user.lastname
        let email = user.email
        let password = user.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            self.db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "firstname": firstname,
                    "lastname": lastname,
                    "email": email
                ]) { error in
                    
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }
}
