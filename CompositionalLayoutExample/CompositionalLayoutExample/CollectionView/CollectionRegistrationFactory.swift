import UIKit

struct CollectionRegistrationFactory {

    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<SectionHeaderView>
    typealias BestArticleCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        CollectionDataSource.Item.Article
    >
    typealias PopularArticleCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        CollectionDataSource.Item.Article
    >
    typealias RegularArticleCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        CollectionDataSource.Item.Article
    >

    func makeHeaderRegistration(dataSource: CollectionDataSource) -> HeaderRegistration {
        return HeaderRegistration(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { [weak dataSource] header, _, indexPath in
            guard let section = dataSource?.sectionIdentifier(for: indexPath.section) else {
                return
            }
            header.configure(with: section.name)
        }
    }

    func makeBestArticleCellRegistration() -> BestArticleCellRegistration {
        return BestArticleCellRegistration { cell, _, item in
            configureArticleCell(
                cell,
                with: item,
                showsImage: true,
                showsSubtitle: true
            )
        }
    }

    func makePopularArticleCellRegistration() -> PopularArticleCellRegistration {
        return PopularArticleCellRegistration { cell, _, item in
            configureArticleCell(
                cell,
                with: item,
                showsImage: true,
                showsSubtitle: false
            )
        }
    }

    func makeRegularArticleCellRegistration() -> RegularArticleCellRegistration {
        return RegularArticleCellRegistration { cell, _, item in
            configureArticleCell(
                cell,
                with: item,
                showsImage: false,
                showsSubtitle: false
            )
        }
    }

    private func configureArticleCell(
        _ cell: UICollectionViewCell,
        with article: CollectionDataSource.Item.Article,
        showsImage: Bool,
        showsSubtitle: Bool
    ) {
        var contentConfiguration: UIListContentConfiguration = showsSubtitle
            ? .subtitleCell()
            : .cell()

        contentConfiguration.text = article.title
        contentConfiguration.textProperties.numberOfLines = 2

        if showsSubtitle {
            contentConfiguration.secondaryText = article.subtitle
            contentConfiguration.secondaryTextProperties.numberOfLines = 2
        }

        if showsImage {
            contentConfiguration.image = article.image
            contentConfiguration.imageProperties.maximumSize = CGSize(width: 48.0, height: 48.0)
            contentConfiguration.imageProperties.cornerRadius = 6.0
        }

        cell.contentConfiguration = contentConfiguration

        var backgroundConfiguration = UIBackgroundConfiguration.listCell()
        backgroundConfiguration.backgroundColor = .secondarySystemBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }

}
