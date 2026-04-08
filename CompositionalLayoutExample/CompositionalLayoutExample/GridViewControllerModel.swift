import UIKit

extension GridViewController {
    enum Model {
        case top(Top)
        case regular(Regular)
    }
}

extension GridViewController.Model {
    struct Top {
        enum Item {
            case bestArticle(Article)
            case popularArticle(Article)
        }

        let name: String
        let background: UIColor
        let items: [Item]
    }

    struct Regular {
        enum Item {
            case article(Article)
        }

        let name: String
        let background: UIColor
        let items: [Item]
    }

    struct Article: Hashable {
        let title: String
        let subtitle: String
        let image: UIImage
    }
}

extension Array where Element == GridViewController.Model {
    static let `default`: [GridViewController.Model] = [
        .top(
            GridViewController.Model.Top(
                name: "Top",
                background: .magenta,
                items: [
                    .bestArticle(
                        GridViewController.Model.Article(
                            title: "Match of the Week",
                            subtitle: "An instant classic with a dramatic finish",
                            image: UIImage(systemName: "trophy.fill")!
                        )
                    ),
                    .popularArticle(
                        GridViewController.Model.Article(
                            title: "Rising Stars to Watch",
                            subtitle: "New names leading the scoreboard",
                            image: UIImage(systemName: "star.fill")!
                        )
                    ),
                    .popularArticle(
                        GridViewController.Model.Article(
                            title: "League Highlights",
                            subtitle: "Top moments from the weekend",
                            image: UIImage(systemName: "sparkles")!
                        )
                    )
                ]
            )
        ),
        .regular(
            GridViewController.Model.Regular(
                name: "Animals",
                background: .green,
                items: [
                    .article(
                        GridViewController.Model.Article(
                            title: "Wildlife Rescue Stories",
                            subtitle: "How volunteers help injured animals",
                            image: UIImage(systemName: "pawprint.fill")!
                        )
                    ),
                    .article(
                        GridViewController.Model.Article(
                            title: "Life in the Rainforest",
                            subtitle: "The hidden world of canopy creatures",
                            image: UIImage(systemName: "leaf.fill")!
                        )
                    ),
                    .article(
                        GridViewController.Model.Article(
                            title: "Ocean Giants",
                            subtitle: "Understanding whales and their migration",
                            image: UIImage(systemName: "drop.fill")!
                        )
                    )
                ]
            )
        ),
        .regular(
            GridViewController.Model.Regular(
                name: "Travel",
                background: .yellow,
                items: [
                    .article(
                        GridViewController.Model.Article(
                            title: "Weekend in Lisbon",
                            subtitle: "A guide to food, views, and trams",
                            image: UIImage(systemName: "airplane")!
                        )
                    ),
                    .article(
                        GridViewController.Model.Article(
                            title: "Mountain Escape",
                            subtitle: "Best trails for first-time hikers",
                            image: UIImage(systemName: "mountain.2.fill")!
                        )
                    ),
                    .article(
                        GridViewController.Model.Article(
                            title: "City on Foot",
                            subtitle: "Walking tours through historic streets",
                            image: UIImage(systemName: "figure.walk")!
                        )
                    ),
                    .article(
                        GridViewController.Model.Article(
                            title: "Island Hopping",
                            subtitle: "Planning a stress-free ferry route",
                            image: UIImage(systemName: "ferry.fill")!
                        )
                    ),
                    .article(
                        GridViewController.Model.Article(
                            title: "Northern Lights",
                            subtitle: "When and where to see the aurora",
                            image: UIImage(systemName: "sparkle")!
                        )
                    )
                ]
            )
        )
    ]
}
