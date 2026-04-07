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
            cell.backgroundColor = .red
        }
    }

    func makePopularArticleCellRegistration() -> PopularArticleCellRegistration {
        return PopularArticleCellRegistration { cell, _, item in
            cell.backgroundColor = .green
        }
    }

    func makeCommonArticleCellRegistration() -> CommonArticleCellRegistration {
        return CommonArticleCellRegistration { cell, _, item in
            cell.backgroundColor = .green
        }
    }

}
