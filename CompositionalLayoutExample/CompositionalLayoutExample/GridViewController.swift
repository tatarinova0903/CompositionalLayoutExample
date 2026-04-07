//
//  ViewController.swift
//  CompositionalLayoutExample
//
//  Created by Daria Tatarinova on 07.04.2026.
//

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

        collectionViewDataSource.apply(
            [
                .statistic(
                    Model.Statistic(
                        name: "Statistic",
                        background: Model.Statistic.Background(firstTeamColor: .red, secondTeamColor: .blue),
                        items: [.compare(1), .liveLeaders(2), .liveLeaders(3)]
                    )
                ),
                .leaders(
                    Model.Leaders(
                        name: "Leaders",
                        items: [.leader(1), .leader(2), .leader(3)]
                    )
                ),
            ],
            animated: true
        )
    }

    private func setupLayout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 500.0)
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
        static var collectionHeight: CGFloat { 500.0 }
        static var horizontalContentInset: CGFloat { 16.0 }
    }
}
