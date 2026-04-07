import UIKit

@MainActor
struct SportStatisticCollectionRegistrationFactory {

    // MARK: - Internal Types

    typealias DataSource = SportStatisticCollectionDataSource
    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<SportStatisticSectionHeaderView>
    typealias BestArticleCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.Article
    >
    typealias PopularArticleCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.Article
    >
    typealias CommonArticleCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.Article
    >
    typealias ViewState = GridViewController.Model

    // MARK: - Internal Methods

    func makeHeaderRegistration(dataSource: DataSource) -> HeaderRegistration {
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

    func makeCommonArticleCellRegistration() -> CommonArticleCellRegistration {
        return CommonArticleCellRegistration { cell, _, item in
            configureArticleCell(
                cell,
                with: item,
                showsImage: false,
                showsSubtitle: false
            )
        }
    }

    // MARK: - Private Methods

    private func configureArticleCell(
        _ cell: UICollectionViewCell,
        with article: ViewState.Article,
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
