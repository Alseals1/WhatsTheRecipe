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
        setupHeader()
        dummyData()
    }
    
    private func registerCell() {
        collectionView.register(HeaderDetailCell.nib, forCellWithReuseIdentifier: HeaderDetailCell.reuseIdentifier)
        collectionView.register(CookingTimeCell.nib, forCellWithReuseIdentifier: CookingTimeCell.reuseIdentifier)
        collectionView.register(IngredientsCell.nib, forCellWithReuseIdentifier: IngredientsCell.reuseIdentifier)
        
        collectionView.register(HeaderCell.nib, forSupplementaryViewOfKind: HeaderCell.kind, withReuseIdentifier: HeaderCell.reuseIdentifier)
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    private func setupData() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, food in
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
                    return self.configure(IngredientsCell.self, with: food, for: indexPath)
                    
                default: return nil
            }
        })
    }
    
    func setupHeader() {
        datasource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self = self else { return UICollectionReusableView() }
            
            let snapshot = self.datasource.snapshot()
            let sectionkind = snapshot.sectionIdentifiers[indexPath.section].kind
            
            switch sectionkind {
                case .ingredient:
                    let cell = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCell.kind, withReuseIdentifier: HeaderCell.reuseIdentifier, for: indexPath) as! HeaderCell
                    cell.setupTitle("Ingredients")
                    return cell
               
                default: return nil
            }
        }
    }
}

extension RecipeViewController {
    private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with food: Food, for indexPath: IndexPath) -> T {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
             fatalError("Unable to dequeue \(cellType)")
         }
         cell.configure(with: food)
         return cell
     }
    
    func dummyData() {
        let section = [
            Section(kind: .cookDetail, item: [Food()]),
            Section(kind: .cookingTime, item: [Food()]),
            Section(kind: .ingredient, item: [
                Food(recipe: "2 tsp Dijon mustard"),
                Food(recipe: "1 tbsp capers"),
                Food(recipe: "1 clove garlic"),
                Food(recipe: "1 tbsp red wine vinegar"),
                Food(recipe: "Juice of ½ lemon"),
                Food(recipe: "4 stems mint, leaves only"),
                Food(recipe: "2 cup marinade"),
                Food(recipe: "2 tsp Butter")
            ])
        ]
        snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections(section)
        section.forEach { snapshot.appendItems($0.item, toSection: $0) }
        datasource.apply(snapshot, animatingDifferences: false)
    }
}
