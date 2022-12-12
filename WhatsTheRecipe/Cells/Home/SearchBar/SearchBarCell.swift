//
//  SearchBarCell.swift
//  WhatsTheRecipe
//
//  Created by Alandis Seals on 12/12/22.
//

import UIKit

class SearchBarCell: UICollectionReusableView {
    static let reuseIdentifier = String(describing: SearchBarCell.self)
    static let kind = String(describing: SearchBarCell.self)
    static let nib = UINib(nibName: String(describing: SearchBarCell.self), bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
