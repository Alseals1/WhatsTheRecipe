import UIKit

class ProfileInfoCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ProfileInfoCell.self)
    static let kind = String(describing: ProfileInfoCell.self)
    static let nib = UINib(nibName: String(describing: ProfileInfoCell.self), bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
