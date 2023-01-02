import Foundation
import UIKit

class AlertManager {
    private static func showBasicAlert(on vc: UIViewController, with title: String, and message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            vc.present(alert, animated: true)
        }
    }
}

extension AlertManager {
    
    public static func showValidEmailAlert(on vc: UIViewController) {
       showBasicAlert(on: vc, with: "Invalid Email", and: "Please Enter A Valid Email")
    }
    
    public static func showValidPasswordAlert(on vc: UIViewController) {
       showBasicAlert(on: vc, with: "Invalid Password", and: "Please Enter A Valid Password")
    }
    
    
    
}

extension AlertManager {
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, message: String) {
        showBasicAlert(on: vc, with: message, and: nil)
    }
}
