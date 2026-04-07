import UIKit
import SwiftUI

final class SportStatisticCollectionDataSource: UICollectionViewDiffableDataSource<
    SportStatisticCollectionDataSource.Section,
    SportStatisticCollectionDataSource.Item
> {

    // MARK: - Internal Types

    typealias ViewState = GridViewController.Model

    struct Section: Hashable {
        enum SectionType: Hashable {
            struct Background: Hashable {
                let firstTeamColor: UIColor
                let secondTeamColor: UIColor
            }

            case statistic(Background)
            case leaders
        }

        let type: SectionType
        let name: String
    }

    enum Item: Hashable {
        case compare(ViewState.Statistic.Item.Compare)
        case liveLeader(ViewState.Statistic.Item.LiveLeader)
        case leader(ViewState.Leaders.Item.Leader)
    }

    // MARK: - Internal Init

    init(
        collectionView: UICollectionView,
        registrationFactory: SportStatisticCollectionRegistrationFactory
    ) {
        let compareCellRegistration = registrationFactory.makeCompareCellRegistration()
        let liveLeaderCellRegistration = registrationFactory.makeLiveLeaderCellRegistration()
        let leaderCellRegistration = registrationFactory.makeLeaderCellRegistration()

        super.init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .compare(let compare):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: compareCellRegistration,
                        for: indexPath,
                        item: compare
                    )
                case .liveLeader(let liveLeader):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: liveLeaderCellRegistration,
                        for: indexPath,
                        item: liveLeader
                    )
                case .leader(let leader):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: leaderCellRegistration,
                        for: indexPath,
                        item: leader
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
            case .statistic(let statistic):
                return Section(
                    type: .statistic(statistic.sectionBackground),
                    name: statistic.name
                )
            case .leaders(let leaders):
                return Section(type: .leaders, name: leaders.name)
            }
        }
        snapshot.appendSections(snapshotSections)

        for section in sections {
            switch section {
            case .statistic(let statistic):
                let snapshotItems: [Item] = statistic.items.map {
                    switch $0 {
                    case .compare(let compare):
                        return .compare(compare)
                    case .liveLeaders(let liveLeader):
                        return .liveLeader(liveLeader)
                    }
                }
                snapshot.appendItems(
                    snapshotItems,
                    toSection: Section(
                        type: .statistic(statistic.sectionBackground),
                        name: statistic.name
                    )
                )
            case .leaders(let leaders):
                let snapshotItems: [Item] = leaders.items.map {
                    switch $0 {
                    case .leader(let leader):
                        return .leader(leader)
                    }
                }
                snapshot.appendItems(snapshotItems, toSection: Section(type: .leaders, name: leaders.name))
            }
        }

        if animated {
            apply(snapshot, animatingDifferences: animated)
        } else {
            applySnapshotUsingReloadData(snapshot)
        }
    }

}

// MARK: - Helpers

extension SportStatisticCollectionDataSource.ViewState.Statistic {
    fileprivate var sectionBackground: SportStatisticCollectionDataSource.Section.SectionType.Background {
        SportStatisticCollectionDataSource.Section.SectionType.Background(
            firstTeamColor: background.firstTeamColor,
            secondTeamColor: background.secondTeamColor
        )
    }
}
