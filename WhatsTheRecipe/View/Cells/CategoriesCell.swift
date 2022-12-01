//
//  CategoriesCell.swift
//  WhatsTheRecipe
//
//  Created by Alandis Seals on 12/1/22.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CategoriesCell.self)
    static let kind = String(describing: CategoriesCell.self)
    static let nib = UINib(nibName: String(describing: CategoriesCell.self), bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
