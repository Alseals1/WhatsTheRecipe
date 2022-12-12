import UIKit

class NewestRecipeCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: NewestRecipeCell.self)
    static let kind = String(describing: NewestRecipeCell.self)
    static let nib = UINib(nibName: String(describing: NewestRecipeCell.self), bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
}
