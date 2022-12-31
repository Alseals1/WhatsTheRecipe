import UIKit

class SignInController: UIViewController {
    @IBOutlet weak var signinTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
        
        
        
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
