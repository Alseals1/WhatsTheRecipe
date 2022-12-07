import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       recipeDetail()
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
