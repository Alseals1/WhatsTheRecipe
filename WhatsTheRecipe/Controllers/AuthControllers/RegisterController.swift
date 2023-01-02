import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterController: UIViewController {
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        
        let error = validateFields()
        
        if error != nil {
            AlertManager.showRegistrationErrorAlert(on: self, message: "All fields need to be fill")
        }else {
            
            let firstname = firstnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                if err != nil {
                    AlertManager.showRegistrationErrorAlert(on: self, message: "Error creating user")
                }
                guard let resultUser = result?.user else {
                   
                    return
                }
                self.db.collection("users").addDocument(data: [
                    "firstname": firstname,
                    "lastname": lastname,
                    "email": email,
                    "uid": resultUser.uid
                ]) { err in
                    AlertManager.showRegistrationErrorAlert(on: self, message: err?.localizedDescription ?? "OPPPS!! Try again later")
                }
                self.transitionToHome()
            }
        }
        
    }
    
    @IBAction func termsPolicyPressed(_ sender: UIButton) {
        
        let webViewer = WebViewerController(with: "https://www.apple.com/legal/internet-services/itunes/")
        let nav = UINavigationController(rootViewController: webViewer)
        self.present(nav, animated: true)
        
    }

}

extension RegisterController {
    
    func transitionToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String? {
        
        if firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
      if isPasswordValid(cleanPassword) == false {
         return "Plaease make sure your password is a least 8 characters, contain a special character and a number."
        }
        return nil
    }
}


