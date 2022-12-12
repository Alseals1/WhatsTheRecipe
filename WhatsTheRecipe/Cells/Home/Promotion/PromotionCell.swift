import UIKit

class PromotionCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: PromotionCell.self)
    static let kind = String(describing: PromotionCell.self)
    static let nib = UINib(nibName: String(describing: PromotionCell.self), bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
