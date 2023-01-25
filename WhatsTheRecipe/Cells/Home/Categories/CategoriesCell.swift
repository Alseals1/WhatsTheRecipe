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
    @IBOutlet weak var moreLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with recipe: Recipe) {
        if recipe.image.hasPrefix("icon") {
            iconImage.image = UIImage(named: recipe.image)
            imageBGView.backgroundColor = UIColor(named: "orangeLT")
            moreLbl.text = ""
        } else {
            iconImage.image = nil
            moreLbl.text = "More"
            moreLbl.textColor = .white
            imageBGView.backgroundColor = .orange
            imageBGView.layer.borderWidth = 0
            imageBGView.layer.borderColor = UIColor.clear.cgColor
        }
         
    }
}
