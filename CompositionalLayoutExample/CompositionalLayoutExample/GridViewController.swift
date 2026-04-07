import UIKit

final class GridViewController: UIViewController {

    private lazy var collectionViewLayout = SportStatisticCollectionLayout { [weak self] sectionIndex in
        self?.collectionViewDataSource.sectionIdentifier(for: sectionIndex)
    }

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var collectionViewDataSource = SportStatisticCollectionDataSource(
        collectionView: collectionView,
        registrationFactory: SportStatisticCollectionRegistrationFactory()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        configureCollectionView()

        collectionViewDataSource.apply(.default, animated: true)
    }

    private func setupLayout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Layout.collectionHeight)
        ])
    }

    private func configureCollectionView() {
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: Layout.horizontalContentInset,
            bottom: 0,
            right: Layout.horizontalContentInset
        )
        collectionView.dataSource = collectionViewDataSource
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
    }

}

extension GridViewController {
    private enum Layout {
        static var collectionHeight: CGFloat { 300.0 }
        static var horizontalContentInset: CGFloat { 16.0 }
    }
}
