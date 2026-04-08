import UIKit

final class GridViewController: UIViewController {

    private lazy var collectionViewLayout = CollectionLayout { [weak self] sectionIndex in
        self?.collectionViewDataSource.sectionIdentifier(for: sectionIndex)
    }

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var collectionViewDataSource = CollectionDataSource(
        collectionView: collectionView,
        registrationFactory: CollectionRegistrationFactory()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        configureCollectionView()
    }

    private func setupLayout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300.0)
        ])
    }

    private func configureCollectionView() {
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 16.0,
            bottom: 0,
            right: 16.0
        )
        collectionView.dataSource = collectionViewDataSource
        collectionView.showsHorizontalScrollIndicator = false
    }

}
