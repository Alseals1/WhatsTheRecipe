import UIKit

class RegisterController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func termsPolicyPressed(_ sender: UIButton) {
        
        let webViewer = WebViewerController(with: "https://www.apple.com/legal/internet-services/itunes/")
        let nav = UINavigationController(rootViewController: webViewer)
        self.present(nav, animated: true)
        
    }
    
   

}


