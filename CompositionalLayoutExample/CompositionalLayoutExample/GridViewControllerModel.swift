//
//  GridViewModel.swift
//  CompositionalLayoutExample
//
//  Created by Daria Tatarinova on 07.04.2026.
//

import UIKit

extension GridViewController {
    enum Model {
        case statistic(Statistic)
        case leaders(Leaders)
        case footballTeam(FootballTeam)
        case hockeyTeam(HockeyTeam)
    }
}

extension GridViewController.Model {
    struct Statistic {
        enum Item {
            typealias Compare = Int
            typealias LiveLeader = Int

            case compare(Compare)
            case liveLeaders(LiveLeader)
        }

        struct Background {
            let firstTeamColor: UIColor
            let secondTeamColor: UIColor
        }

        let name: String
        let background: Background
        let items: [Item]
    }

    struct Leaders {
        enum Item {
            typealias Leader = Int

            case leader(Leader)
        }

        let name: String
        let items: [Item]
    }

    struct FootballTeam {
        enum Item {
            typealias FootballPlayersList = Int
            typealias FootballPlacementScheme = Int

            case footballPlayersList(FootballPlayersList)
            case footballPlacementScheme(FootballPlacementScheme)
        }

        let name: String
        let items: [Item]
    }

    struct HockeyTeam {
        enum Item {
            typealias HockeyPlayersList = Int
            typealias HockeyPlayersListRelated = Int

            case hockeyPlayersList(HockeyPlayersList)
            case hockeyPlayersListRelated(HockeyPlayersListRelated)
        }

        let name: String
        let items: [Item]
    }
}
