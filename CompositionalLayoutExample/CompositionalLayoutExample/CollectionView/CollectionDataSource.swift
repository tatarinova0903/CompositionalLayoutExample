//
//  CollectionDataSource.swift
//  CompositionalLayoutExample
//
//  Created by Daria Tatarinova on 07.04.2026.
//

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
            case footballTeam
            case hockeyTeam
        }

        let type: SectionType
        let name: String
    }

    enum Item: Hashable {
        case compare(ViewState.Statistic.Item.Compare)
        case liveLeader(ViewState.Statistic.Item.LiveLeader)
        case leader(ViewState.Leaders.Item.Leader)
        case footballPlayersList(ViewState.FootballTeam.Item.FootballPlayersList)
        case footballPlacementScheme(ViewState.FootballTeam.Item.FootballPlacementScheme)
        case hockeyPlayersList(ViewState.HockeyTeam.Item.HockeyPlayersList)
        case hockeyPlayersListRelated(ViewState.HockeyTeam.Item.HockeyPlayersListRelated)
    }

    // MARK: - Internal Init

    init(
        collectionView: UICollectionView,
        registrationFactory: SportStatisticCollectionRegistrationFactory
    ) {
        let compareCellRegistration = registrationFactory.makeCompareCellRegistration()
        let liveLeaderCellRegistration = registrationFactory.makeLiveLeaderCellRegistration()
        let leaderCellRegistration = registrationFactory.makeLeaderCellRegistration()
        let hockeyPlayersListCellRegistration = registrationFactory.makeHockeyPlayersListCellRegistration()
        let hockeyPlayersListRelatedCellRegistration = registrationFactory.makeHockeyPlayersListRelatedCellRegistration()
        let footballPlayersListCellRegistration = registrationFactory.makeFootballPlayersListCellRegistration()
        let footballPlacementSchemeCellRegistration = registrationFactory.makeFootballPlacementSchemeCellRegistration()

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
                case .hockeyPlayersList(let hockeyPlayersList):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: hockeyPlayersListCellRegistration,
                        for: indexPath,
                        item: hockeyPlayersList
                    )
                case .hockeyPlayersListRelated(let hockeyPlayersListRelated):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: hockeyPlayersListRelatedCellRegistration,
                        for: indexPath,
                        item: hockeyPlayersListRelated
                    )
                case .footballPlayersList(let footballPlayersList):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: footballPlayersListCellRegistration,
                        for: indexPath,
                        item: footballPlayersList
                    )
                case .footballPlacementScheme(let footballPlacementScheme):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: footballPlacementSchemeCellRegistration,
                        for: indexPath,
                        item: footballPlacementScheme
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
            case .footballTeam(let footballTeam):
                return Section(type: .footballTeam, name: footballTeam.name)
            case .hockeyTeam(let hockeyTeam):
                return Section(type: .hockeyTeam, name: hockeyTeam.name)
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
            case .footballTeam(let footballTeam):
                let snapshotItems: [Item] = footballTeam.items.map {
                    switch $0 {
                    case .footballPlayersList(let footballPlayersList):
                        return .footballPlayersList(footballPlayersList)
                    case .footballPlacementScheme(let footballPlacementScheme):
                        return .footballPlacementScheme(footballPlacementScheme)
                    }
                }
                snapshot.appendItems(snapshotItems, toSection: Section(type: .footballTeam, name: footballTeam.name))
            case .hockeyTeam(let hockeyTeam):
                let snapshotItems: [Item] = hockeyTeam.items.map {
                    switch $0 {
                    case .hockeyPlayersList(let hockeyPlayersList):
                        return .hockeyPlayersList(hockeyPlayersList)
                    case .hockeyPlayersListRelated(let hockeyPlayersListRelated):
                        return .hockeyPlayersListRelated(hockeyPlayersListRelated)
                    }
                }
                snapshot.appendItems(snapshotItems, toSection: Section(type: .hockeyTeam, name: hockeyTeam.name))
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
