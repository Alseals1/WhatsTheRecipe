import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    let section = Bundle.main.decode([Section].self, from: "foodData.json")
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
    private var categories = [Category]()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, env) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let snapshot = self.dataSource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[sectionIndex].kind
            
            switch sectionKind {
                case "profileInfo":
                    return LayoutSectionFactory().profileInfoLayout()
                case "category":
                    return LayoutSectionFactory().categoryLayout()
                case "promotion":
                    return LayoutSectionFactory().promotionLayout()
                case "newestRecipe":
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
        navigationItem.hidesBackButton = true
        configureItem()
        registerCell()
        setupDataSource()
        
       
    }

    func registerCell() {
        collectionView.register(ProfileInfoCell.nib, forCellWithReuseIdentifier: ProfileInfoCell.reuseIdentifier)
        collectionView.register(CategoriesCell.nib, forCellWithReuseIdentifier: CategoriesCell.reuseIdentifier)
        collectionView.register(PromotionCell.nib, forCellWithReuseIdentifier: PromotionCell.reuseIdentifier)
        collectionView.register(NewestRecipeCell.nib, forCellWithReuseIdentifier: NewestRecipeCell.reuseIdentifier)
        
        collectionView.register(HeaderCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier)
        collectionView.register(SearchBarCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SearchBarCell.reuseIdentifier)
        
        collectionView.collectionViewLayout = collectionViewLayout
    }
 
    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Recipe>(collectionView: collectionView){ [weak self] (collectionView, indexPath, recipe) in
            guard let self = self else { return UICollectionViewCell() }
            
            let snapshot = self.dataSource.snapshot()
            let sectionKind = snapshot.sectionIdentifiers[indexPath.section].kind
            
            switch sectionKind {
                case "profileInfo":
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileInfoCell.reuseIdentifier, for: indexPath)
                    return cell
                case "category":
                  return self.configure(CategoriesCell.self, with: recipe, for: indexPath)
                case "promotion":
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCell.reuseIdentifier, for: indexPath)
                    return cell
                case "newestRecipe":
                    return self.configure(NewestRecipeCell.self, with: recipe, for: indexPath)
                    
                default: return nil
            }
        }
        setupHeader()
        
        
        snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
        snapshot.appendSections(section)
        section.forEach { snapshot.appendItems($0.recipes, toSection: $0) }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func setupHeader() {
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self = self else { return UICollectionReusableView() }
            
            //let snapshot = self.dataSource.snapshot()
            //let sectionkind = snapshot.sectionIdentifiers[indexPath.section].kind
            
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier, for: indexPath) as! HeaderCell
                header.headerTitleLbl.text = self.section[indexPath.section].title
                return header
                
            }  else if kind == UICollectionView.elementKindSectionFooter {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SearchBarCell.reuseIdentifier, for: indexPath)
                return footer
            }
            return UICollectionReusableView()
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
   private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with recipe: Recipe, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: recipe)
        return cell
    }
    
    func configureItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(handleSignOut))
    }
    
    @objc func handleSignOut() {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            self.didTapSignOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
     func didTapSignOut() {
        let firebaseAuth = Auth.auth()
        do {
            print("Signing out")
           try? firebaseAuth.signOut()
            
           
        }
    }
}


