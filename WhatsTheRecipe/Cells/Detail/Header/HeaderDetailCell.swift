//
//  HeaderDetailCell.swift
//  WhatsTheRecipe
//
//  Created by Alandis Seals on 12/8/22.
//

import UIKit

class HeaderDetailCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: HeaderDetailCell.self)
    static let kind = String(describing: HeaderDetailCell.self)
    static let nib = UINib(nibName: String(describing: HeaderDetailCell.self), bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
