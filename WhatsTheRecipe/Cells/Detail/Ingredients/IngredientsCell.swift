import UIKit

class IngredientsCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: IngredientsCell.self)
    static let kind = String(describing: IngredientsCell.self)
    static let nib = UINib(nibName: String(describing: IngredientsCell.self), bundle: nil)

    @IBOutlet weak var bubbleImage: UIImageView!
    @IBOutlet weak var ingredientLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //func configure(with recipe: Recipe) {
       // ingredientLbl.text = (food.recipe)
        
    //}
}
