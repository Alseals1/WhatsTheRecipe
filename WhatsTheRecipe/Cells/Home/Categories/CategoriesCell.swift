//
//  CategoriesCell.swift
//  WhatsTheRecipe
//
//  Created by Alandis Seals on 12/1/22.
//

import UIKit

class CategoriesCell: UICollectionViewCell, SelfConfiguringCell {
    
    static let reuseIdentifier = String(describing: CategoriesCell.self)
    static let kind = String(describing: CategoriesCell.self)
    static let nib = UINib(nibName: String(describing: CategoriesCell.self), bundle: nil)
    
    @IBOutlet weak var imageBGView: UIView!
    @IBOutlet weak var iconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with food: Food) {
        
        if food.image.hasPrefix("icon") {
            iconImage.image = UIImage(named: food.image)
            imageBGView.backgroundColor = UIColor(named: "orangeLT")
        } else {
            iconImage.image = UIImage(named: "more")
            imageBGView.backgroundColor = .orange
            imageBGView.layer.borderWidth = 0
            imageBGView.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
