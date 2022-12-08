//
//  IngredientsCell.swift
//  WhatsTheRecipe
//
//  Created by Alandis Seals on 12/8/22.
//

import UIKit

class IngredientsCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: IngredientsCell.self)
    static let kind = String(describing: IngredientsCell.self)
    static let nib = UINib(nibName: String(describing: IngredientsCell.self), bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
