import UIKit

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with food: Food)
}

class HomeViewController: UIViewController {
   
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
                case .profileInfo:
                    return LayoutSectionFactory().profileInfoLayout()
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
        modalPresentationStyle = .fullScreen
        initialize()
    }
    
    func initialize() {
        setupDataSource()
        setupHeader()
        registerCell()
        dummyData()
    }

    func registerCell() {
        collectionView.register(ProfileInfoCell.nib, forCellWithReuseIdentifier: ProfileInfoCell.reuseIdentifier)
        collectionView.register(CategoriesCell.nib, forCellWithReuseIdentifier: CategoriesCell.reuseIdentifier)
        collectionView.register(PromotionCell.nib, forCellWithReuseIdentifier: PromotionCell.reuseIdentifier)
        collectionView.register(NewestRecipeCell.nib, forCellWithReuseIdentifier: NewestRecipeCell.reuseIdentifier)
        
        collectionView.register(HeaderCell.nib, forSupplementaryViewOfKind: HeaderCell.kind, withReuseIdentifier: HeaderCell.reuseIdentifier)
        
        collectionView.register(SearchBarCell.nib, forSupplementaryViewOfKind: SearchBarCell.kind, withReuseIdentifier: SearchBarCell.reuseIdentifier)
        collectionView.collectionViewLayout = collectionViewLayout
    }
 
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Food>(collectionView: collectionView){ [weak self] (collectionView, indexPath, food) in
            guard let self = self else { return UICollectionViewCell() }
            
            let snapshot = self.dataSource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[indexPath.section].kind
            
            switch sectionKind {
                case .profileInfo:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileInfoCell.reuseIdentifier, for: indexPath)
                    return cell
                    
                case .categories:
                  return self.configure(CategoriesCell.self, with: food, for: indexPath)
                  
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
    
    func setupHeader() {
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self = self else { return UICollectionReusableView() }
            
            let snapshot = self.dataSource.snapshot()
            let sectionkind = snapshot.sectionIdentifiers[indexPath.section].kind
            
            switch sectionkind {
                case .profileInfo:
                    let cell = collectionView.dequeueReusableSupplementaryView(ofKind: SearchBarCell.kind, withReuseIdentifier: SearchBarCell.reuseIdentifier, for: indexPath)
                    
                    return cell
                    
                case .categories:
                    let cell = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCell.kind, withReuseIdentifier: HeaderCell.reuseIdentifier, for: indexPath) as! HeaderCell
                    cell.setupTitle("Categories")
                    return cell
                case .newestRecipe:
                    let cell = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCell.kind, withReuseIdentifier: HeaderCell.reuseIdentifier, for: indexPath) as! HeaderCell
                    cell.setupTitle("Newest Recipe")
                    return cell
                default: return nil
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "RecipeStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecipeViewController")
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
        
    }
}

extension HomeViewController {
   private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with food: Food, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: food)
        return cell
    }
    
    func dummyData() {
        let section = [
            Section(kind: .profileInfo, item:[
                Food()
                ]),
            Section(kind: .categories, item:[
                Food(image: "icon4"),
                Food(image: "icon6"),
                Food(image: "icon0"),
                Food(image: "icon1"),
                Food(image: "icon2"),
                Food(image: "icon5"),
                Food(image: "icon3"),
                Food(image: "more")
            ]),
            Section(kind: .promotion, item: [Food()]),
            Section(kind: .newestRecipe, item: [Food(),Food(),Food(),Food(),Food(),Food(),Food(),Food()])
            
        ]
        snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
        snapshot.appendSections(section)
        section.forEach { snapshot.appendItems($0.item, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


