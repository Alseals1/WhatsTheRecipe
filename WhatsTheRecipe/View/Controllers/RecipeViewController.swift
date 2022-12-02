//
//  RecipeViewController.swift
//  WhatsTheRecipe
//
//  Created by Alandis Seals on 12/2/22.
//

import UIKit

class RecipeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       recipeDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recipeDetail()
    }
    
//    override func viewdidappear(_ animated: Bool) {
//        recipeDetail()
//    }
    
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
