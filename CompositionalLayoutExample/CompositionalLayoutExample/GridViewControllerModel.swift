import UIKit

extension GridViewController {
    enum Model {
        case top(Top)
        case new(New)
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

    struct New {
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
                background: .red,
                items: [
                    .bestArticle(
                        GridViewController.Model.Article(
                            title: "1",
                            subtitle: "1",
                            image: UIImage(systemName: "heart.fill")!
                        )
                    ),
                    .popularArticle(
                        GridViewController.Model.Article(
                            title: "2",
                            subtitle: "2",
                            image: UIImage(systemName: "heart.fill")!
                        )
                    ),
                    .popularArticle(
                        GridViewController.Model.Article(
                            title: "3",
                            subtitle: "3",
                            image: UIImage(systemName: "heart.fill")!
                        )
                    )
                ]
            )
        ),
        .new(
            GridViewController.Model.New(
                name: "New",
                background: .red,
                items: [
                    .article(
                        GridViewController.Model.Article(
                            title: "1",
                            subtitle: "1",
                            image: UIImage(systemName: "heart.fill")!
                        )
                    ),
                    .article(
                        GridViewController.Model.Article(
                            title: "2",
                            subtitle: "2",
                            image: UIImage(systemName: "heart.fill")!
                        )
                    ),
                    .article(
                        GridViewController.Model.Article(
                            title: "3",
                            subtitle: "3",
                            image: UIImage(systemName: "heart.fill")!
                        )
                    )
                ]
            )
        )
    ]
}
