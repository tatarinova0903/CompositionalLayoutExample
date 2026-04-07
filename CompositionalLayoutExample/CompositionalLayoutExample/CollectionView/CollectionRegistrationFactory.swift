//
//  CollectionRegistrationFactory.swift
//  CompositionalLayoutExample
//
//  Created by Daria Tatarinova on 07.04.2026.
//

import Foundation
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
    typealias HockeyPlayersListCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.HockeyTeam.Item.HockeyPlayersList
    >
    typealias HockeyPlayersListRelatedCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.HockeyTeam.Item.HockeyPlayersListRelated
    >
    typealias FootballPlayersListCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.FootballTeam.Item.FootballPlayersList
    >
    typealias FootballPlacementSchemeCellRegistration = UICollectionView.CellRegistration<
        UICollectionViewCell,
        ViewState.FootballTeam.Item.FootballPlacementScheme
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

    func makeHockeyPlayersListCellRegistration() -> HockeyPlayersListCellRegistration {
        return HockeyPlayersListCellRegistration { cell, _, item in
            cell.backgroundColor = .blue
        }
    }

    func makeHockeyPlayersListRelatedCellRegistration() -> HockeyPlayersListRelatedCellRegistration {
        return HockeyPlayersListRelatedCellRegistration { cell, _, item in
            cell.backgroundColor = .brown
        }
    }

    func makeFootballPlayersListCellRegistration() -> FootballPlayersListCellRegistration {
        return FootballPlayersListCellRegistration { cell, _, item in
            cell.backgroundColor = .gray
        }
    }

    func makeFootballPlacementSchemeCellRegistration() -> FootballPlacementSchemeCellRegistration {
        return FootballPlacementSchemeCellRegistration { cell, _, item in
            cell.backgroundColor = .magenta
        }
    }

}
