import UIKit

class CategoriesCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CategoriesCell.self)
    static let kind = String(describing: CategoriesCell.self)
    static let nib = UINib(nibName: String(describing: CategoriesCell.self), bundle: nil)
    
    @IBOutlet weak var imageBGView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var moreLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with item: Category) {
        if item.image.hasPrefix("icon") {
            iconImage.image = UIImage(named: item.image)
            imageBGView.backgroundColor = UIColor(named: "orangeLT")
            moreLbl.text = ""
        } else {
            iconImage.image = nil
            moreLbl.text = "More"
            moreLbl.textColor = .white
            imageBGView.backgroundColor = .orange
            imageBGView.layer.borderWidth = 0
            imageBGView.layer.borderColor = UIColor.clear.cgColor
        }
         
    }
}
