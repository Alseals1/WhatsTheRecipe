import UIKit

class RecipeViewController: UIViewController {
    private var datasource: UICollectionViewDiffableDataSource<Section, Food>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, env) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let snapshot = self.datasource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[sectionIndex].kind
            
            
            switch sectionKind {
                case .cookDetail:
                    return LayoutSectionFactory().cookDetailLayout()
                case .cookingTime:
                    return LayoutSectionFactory().cookTimeLayout()
                case .ingredient:
                    return LayoutSectionFactory().ingredientLayout()
                    
                default: return nil
            }
        }
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
       initialize()
    }
    
    private func initialize() {
        registerCell()
        setupData()
        dummyData()
    }
    
   
    
    //IBAction Heart Button
    /*
    @IBAction func heartButtonPressed(_ sender: UIButton) {
          sender.isSelected.toggle()
        if sender.isSelected {
            let likedImage = UIImage(systemName: "hand.thumbsup.fill")
            let tintedImage = likedImage?.withRenderingMode(.alwaysTemplate)
             heartButton.setImage(tintedImage, for: .normal)
            heartButton.tintColor = UIColor(named: "strawberryRed")
        }else {
            heartButton.setImage(UIImage(named: "btnSave"), for: .normal)
        }
    }
    */
    
    private func registerCell() {
        
        collectionView.register(HeaderDetailCell.nib, forCellWithReuseIdentifier: HeaderDetailCell.reuseIdentifier)
        collectionView.register(CookingTimeCell.nib, forCellWithReuseIdentifier: CookingTimeCell.reuseIdentifier)
        collectionView.register(IngredientsCell.nib, forCellWithReuseIdentifier: IngredientsCell.reuseIdentifier)
        
        collectionView.collectionViewLayout = collectionViewLayout
        
    }
    
    private func setupData() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, kind in
            guard let self = self else { return UICollectionViewCell() }
            
            let snapshot = self.datasource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[indexPath.section].kind
            
            switch sectionKind {
                case .cookDetail:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderDetailCell.reuseIdentifier, for: indexPath)
                    return cell
                    
                case .cookingTime:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CookingTimeCell.reuseIdentifier, for: indexPath)
                    return cell
                    
                case .ingredient:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCell.reuseIdentifier, for: indexPath)
                    return cell
                    
                default: return nil
            }
        })
    }
}

extension RecipeViewController {
    func dummyData() {
        let section = [
            Section(kind: .cookDetail, item: [Food()]),
            Section(kind: .cookingTime, item: [Food()]),
            Section(kind: .ingredient, item: [Food(),Food(),Food(),Food(),Food(),Food(),Food(),Food(),])
        ]
        snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections(section)
        section.forEach { snapshot.appendItems($0.item, toSection: $0) }
        datasource.apply(snapshot, animatingDifferences: false)
    }
    
}
