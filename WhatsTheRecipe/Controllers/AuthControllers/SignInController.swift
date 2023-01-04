import UIKit
import FirebaseAuth

class SignInController: UIViewController {
    
    @IBOutlet weak var signinTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        let email = signinTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        checkAuth(email: email, password: password)
    }
    
    @IBAction func newUserBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AuthStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterController")
        
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func forgotPasswordBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AuthStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordController")
        
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
        
    }
}

extension SignInController {
    func validateFields() -> String? {
        
        if signinTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        return nil
    }
    
    func checkAuth(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil {
                AlertManager.showRegistrationErrorAlert(on: self, message: error!.localizedDescription)
                return
            }else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
                
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(viewController, animated: true)
                
            }
        }
    }
}
