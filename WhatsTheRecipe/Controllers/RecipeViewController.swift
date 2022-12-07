import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var heartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       recipeDetail()
    }
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.viewControllers.remove(at: 1)
    }
    
    
    @IBAction func heartButtonPressed(_ sender: UIButton) {
          sender.isSelected.toggle()
        if sender.isSelected {
            let likedImage = UIImage(systemName: "hand.thumbsup.fill")
            let tintedImage = likedImage?.withRenderingMode(.alwaysTemplate)
             heartButton.setImage(tintedImage, for: .normal)
            heartButton.tintColor = UIColor(named: "strawberryRed")
        }else {
            heartButton.setImage(UIImage(named: "btnSave"), for: .normal)
        }
       
        
     
    }
    
    func recipeDetail(){
        let storyboard = UIStoryboard(name: "RecipeStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController")
        
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .custom(resolver: { _ in
                    return 281
                }),
                .large()
            ]
            presentationController.preferredCornerRadius = 30
            presentationController.prefersGrabberVisible = true
            presentationController.largestUndimmedDetentIdentifier = .large
        }
        self.present(viewController, animated: true)
    }
}
