import UIKit

class HeaderCell: UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: HeaderCell.self)
    static let kind = String(describing: HeaderCell.self)
    static let nib = UINib(nibName: String(describing: HeaderCell.self), bundle: nil)
    
    @IBOutlet weak var headerTitleLbl: UILabel!
    
}
