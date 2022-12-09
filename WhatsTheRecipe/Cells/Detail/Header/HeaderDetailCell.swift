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
    
    @IBOutlet weak var heartButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func heartBtnPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
      if sender.isSelected {
          let likedImage = UIImage(systemName: "hand.thumbsup.fill")
          let tintedImage = likedImage?.withRenderingMode(.alwaysTemplate)
          heartButton.setImage(tintedImage, for: .normal)
          heartButton.tintColor = .white
          heartButton.backgroundColor = UIColor(named: "strawberryRed")
      }else {
          heartButton.setImage(UIImage(named: "btnSave"), for: .normal)
      }
    }
}
