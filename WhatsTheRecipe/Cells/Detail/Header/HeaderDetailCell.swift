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
            
            self.heartButton.tintColor = .white
            self.heartButton.backgroundColor = UIColor(named: "strawberryRed")
            UIButton.animate(withDuration: 1.0, animations: {
                self.heartButton.setImage(UIImage(systemName: "arrow.up.heart.fill"), for: .normal)
                self.heartButton.center.y = self.heartButton.bounds.width - 100
            }, completion: { _ in
                UIButton.animate(withDuration: 1.0, animations: {
                    self.heartButton.center.y = self.heartButton.bounds.width + 100
                    self.heartButton.setImage(tintedImage, for: .normal)
                })
            })
        }else {
            heartButton.setImage(UIImage(named: "btnSave"), for: .normal)
        }
    }
}
