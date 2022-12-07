//
//  HeaderCell.swift
//  WhatsTheRecipe
//
//  Created by Alandis Seals on 12/7/22.
//

import UIKit

class HeaderCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: HeaderCell.self)
    static let kind = String(describing: HeaderCell.self)
    static let nib = UINib(nibName: String(describing: HeaderCell.self), bundle: nil)
    
    @IBOutlet weak var headerTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupTitle(_ title: String) {
        headerTitleLbl.text = title
    }
}
