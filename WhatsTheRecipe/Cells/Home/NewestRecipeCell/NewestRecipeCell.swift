import UIKit

class NewestRecipeCell: UICollectionViewCell, SelfConfiguringCell {
    static let reuseIdentifier = String(describing: NewestRecipeCell.self)
    static let kind = String(describing: NewestRecipeCell.self)
    static let nib = UINib(nibName: String(describing: NewestRecipeCell.self), bundle: nil)
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var mealLbl: UILabel!
    @IBOutlet weak var chefNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func configure(with recipe: Recipe) {
        categoryLbl.text = recipe.category
        mealLbl.text = recipe.title
        if let chef = recipe.chefs.first {
            chefNameLbl.text = chef.name
        }
        mealImage.image = UIImage(named: recipe.image)
        
    }
}
