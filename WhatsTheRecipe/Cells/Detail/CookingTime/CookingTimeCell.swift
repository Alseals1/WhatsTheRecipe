import UIKit

class CookingTimeCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CookingTimeCell.self)
    static let kind = String(describing: CookingTimeCell.self)
    static let nib = UINib(nibName: String(describing: CookingTimeCell.self), bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
