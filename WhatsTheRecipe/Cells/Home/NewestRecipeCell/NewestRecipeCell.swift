import UIKit

class NewestRecipeCell: UICollectionViewCell, SelfConfiguringCell {
    static let reuseIdentifier = String(describing: NewestRecipeCell.self)
    static let kind = String(describing: NewestRecipeCell.self)
    static let nib = UINib(nibName: String(describing: NewestRecipeCell.self), bundle: nil)
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var typeofFoodLbl: UILabel!
    @IBOutlet weak var mealLbl: UILabel!
    @IBOutlet weak var chefNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func configure(with food: Food) {
        typeofFoodLbl.text = food.typeOfFood
        mealLbl.text = food.title
        chefNameLbl.text = food.chefName
        mealImage.image = UIImage(named: food.image)
    }
}
