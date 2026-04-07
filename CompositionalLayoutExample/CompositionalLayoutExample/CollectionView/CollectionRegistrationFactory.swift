import UIKit

@MainActor
struct SportStatisticCollectionRegistrationFactory {

    // MARK: - Internal Types

    typealias DataSource = SportStatisticCollectionDataSource
    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<SportStatisticSectionHeaderView>
    typealias CompareCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.Statistic.Item.Compare
    >
    typealias LeaderCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.Leaders.Item.Leader
    >
    typealias LiveLeaderCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.Statistic.Item.LiveLeader
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

    func makeCompareCellRegistration() -> CompareCellRegistration {
        return CompareCellRegistration { cell, _, item in
            cell.backgroundColor = .red
        }
    }

    func makeLiveLeaderCellRegistration() -> LiveLeaderCellRegistration {
        return LiveLeaderCellRegistration { cell, _, item in
            cell.backgroundColor = .green
        }
    }

    func makeLeaderCellRegistration() -> LeaderCellRegistration {
        return LeaderCellRegistration { cell, _, item in
            cell.backgroundColor = .yellow
        }
    }

}
