import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {
    typealias Item = AnyHashable
    @Published var categorySectionItem: [Item] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var subcription = Set<AnyCancellable>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var collectionViewLayout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [unowned self] index, env in
            return self.sectionFor(index: index, environment: env)
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func initialize() {
        navigationItem.hidesBackButton = true
        registerCell()
        bindData()
    }
    
    private func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.categorySectionItem = Bundle.main.decode([Category].self, from: "category.json")
            dump(self.categorySectionItem )
        }
        
    }
    
    private func sectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = self.dataSource.snapshot().sectionIdentifiers[index]
        switch section {
            case .category: return LayoutSectionFactory().categoryLayout()
        }
    }
    
    func registerCell() {
        collectionView.register(HeaderCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier)
        collectionView.register(CategoriesCell.nib, forCellWithReuseIdentifier: CategoriesCell.reuseIdentifier)
        
        collectionView.collectionViewLayout = collectionViewLayout
        setupDataSource()
        setupHeader()
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            
            let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.category])
        snapshot.appendItems(categorySectionItem, toSection: .category)
        dataSource.apply(snapshot)
    }
    
    private func bindData() {
        $categorySectionItem
            .receive(on: RunLoop.main)
            .sink { item in
                self.applySnapshot(item: item, section: .category)
                
            }.store(in: &subcription)
        
    }
    
    private func applySnapshot(item: [Item], section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(item, toSection: section)
        dataSource.apply(snapshot)
    }
    
    private func configureCell(for section: Section, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        switch section {
            case .category:
                if let category = item as? Category {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseIdentifier , for: indexPath) as! CategoriesCell
                    cell.configure(with: category)
                    return cell
                } else { return nil }
        }
    }
    
    func setupHeader() {
        self.dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseIdentifier, for: indexPath) as! HeaderCell
            header.headerTitleLbl.text = section.sectionTitle
            return header
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController {
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


