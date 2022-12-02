import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Food>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
    private var section = [Section]()
    
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, env) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let snapshot = self.dataSource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[sectionIndex].kind
            
            switch sectionKind {
                case .categories:
                    return LayoutSectionFactory().categoryLayout()
                case .promotion:
                    return LayoutSectionFactory().promotionLayout()
                case .newestRecipe:
                    return LayoutSectionFactory().newestRecipeLayout()
                default: return nil
            }
        }
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        setupDataSource()
        registerCell()
        dummyData()
    }

    func dummyData() {
        let section = [
            Section(kind: .categories, item: [Food(),Food(),Food(),Food(),Food(),Food(),Food(),Food()]),
            Section(kind: .promotion, item: [Food()]),
            Section(kind: .newestRecipe, item: [Food(),Food(),Food(),Food(),Food(),Food(),Food(),Food()])
            
        ]
        snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections(section)
        section.forEach { snapshot.appendItems($0.item, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func registerCell() {
        collectionView.register(CategoriesCell.nib, forCellWithReuseIdentifier: CategoriesCell.reuseIdentifier)
        collectionView.register(PromotionCell.nib, forCellWithReuseIdentifier: PromotionCell.reuseIdentifier)
        collectionView.register(NewestRecipeCell.nib, forCellWithReuseIdentifier: NewestRecipeCell.reuseIdentifier)
        
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Food>(collectionView: collectionView){ [weak self] (collectionView, indexPath, itemIdentifier) in
            guard let self = self else { return UICollectionViewCell() }
            
            let snapshot = self.dataSource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[indexPath.section].kind
            
            switch sectionKind {
                case .categories:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseIdentifier, for: indexPath)
                    return cell
                case .promotion:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCell.reuseIdentifier, for: indexPath)
                    return cell
                case .newestRecipe:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewestRecipeCell.reuseIdentifier, for: indexPath)
                    return cell
                    
                default: return nil
            }
            
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecipeViewController")
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true )
    }
}
