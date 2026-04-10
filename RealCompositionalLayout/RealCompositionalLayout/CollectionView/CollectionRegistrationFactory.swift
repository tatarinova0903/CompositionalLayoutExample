import UIKit

struct CollectionRegistrationFactory {

    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<SectionHeaderView>
    typealias BestArticleCellRegistration = UICollectionView.CellRegistration<
        BestArticleCollectionViewCell,
        CollectionDataSource.Item.Article
    >
    typealias PopularArticleCellRegistration = UICollectionView.CellRegistration<
        PopularArticleCollectionViewCell,
        CollectionDataSource.Item.Article
    >
    typealias RegularArticleCellRegistration = UICollectionView.CellRegistration<
        RegularArticleCollectionViewCell,
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
            cell.configure(with: item)
        }
    }

    func makePopularArticleCellRegistration() -> PopularArticleCellRegistration {
        return PopularArticleCellRegistration { cell, _, item in
            cell.configure(with: item)
        }
    }

    func makeRegularArticleCellRegistration() -> RegularArticleCellRegistration {
        return RegularArticleCellRegistration { cell, _, item in
            cell.configure(with: item)
        }
    }
}
