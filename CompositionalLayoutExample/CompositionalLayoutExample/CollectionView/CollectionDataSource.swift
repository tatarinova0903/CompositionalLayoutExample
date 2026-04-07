import UIKit
import SwiftUI

final class CollectionDataSource: UICollectionViewDiffableDataSource<
    CollectionDataSource.Section,
    CollectionDataSource.Item
> {

    // MARK: - Internal Types

    typealias ViewState = GridViewController.Model

    struct Section: Hashable {
        enum SectionType: Hashable {
            case top(UIColor)
            case new(UIColor)
        }

        let type: SectionType
        let name: String
    }

    enum Item: Hashable {
        case bestArticle(ViewState.Article)
        case popularArticle(ViewState.Article)
        case commonArticle(ViewState.Article)
    }

    // MARK: - Internal Init

    init(
        collectionView: UICollectionView,
        registrationFactory: CollectionRegistrationFactory
    ) {
        let bestArticleCellRegistration = registrationFactory.makeBestArticleCellRegistration()
        let popularArticleCellRegistration = registrationFactory.makePopularArticleCellRegistration()
        let commonArticleCellRegistration = registrationFactory.makeCommonArticleCellRegistration()

        super.init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .bestArticle(let bestArticle):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: bestArticleCellRegistration,
                        for: indexPath,
                        item: bestArticle
                    )
                case .popularArticle(let popularArticle):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: popularArticleCellRegistration,
                        for: indexPath,
                        item: popularArticle
                    )
                case .commonArticle(let commonArticle):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: commonArticleCellRegistration,
                        for: indexPath,
                        item: commonArticle
                    )
                }
            }
        )

        let headerRegistration = registrationFactory.makeHeaderRegistration(dataSource: self)

        supplementaryViewProvider = { collectionView, type, indexPath in
            switch type {
            case UICollectionView.elementKindSectionHeader:
                return collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration,
                    for: indexPath
                )
            default:
                return nil
            }
        }

    }

    // MARK: - Internal Methods

    func apply(_ sections: [ViewState], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()

        let snapshotSections: [Section] = sections.map { section in
            switch section {
            case .top(let top):
                return Section(
                    type: .top(top.background),
                    name: top.name
                )
            case .new(let new):
                return Section(
                    type: .new(new.background),
                    name: new.name
                )
            }
        }
        snapshot.appendSections(snapshotSections)

        for section in sections {
            switch section {
            case .top(let top):
                let snapshotItems: [Item] = top.items.map {
                    switch $0 {
                    case .bestArticle(let article):
                        return .bestArticle(article)
                    case .popularArticle(let article):
                        return .popularArticle(article)
                    }
                }
                snapshot.appendItems(
                    snapshotItems,
                    toSection: Section(type: .top(top.background), name: top.name)
                )
            case .new(let new):
                let snapshotItems: [Item] = new.items.map {
                    switch $0 {
                    case .article(let article):
                        return .commonArticle(article)
                    }
                }
                snapshot.appendItems(
                    snapshotItems,
                    toSection: Section(type: .new(new.background), name: new.name))
            }
        }

        if animated {
            apply(snapshot, animatingDifferences: animated)
        } else {
            applySnapshotUsingReloadData(snapshot)
        }
    }

}
