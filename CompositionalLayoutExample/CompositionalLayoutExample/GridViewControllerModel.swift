import UIKit

extension GridViewController {
    enum Model {
        case statistic(Statistic)
        case leaders(Leaders)
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
}
