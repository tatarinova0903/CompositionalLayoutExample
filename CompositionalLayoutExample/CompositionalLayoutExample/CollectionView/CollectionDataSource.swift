import UIKit

final class CollectionDataSource: UICollectionViewDiffableDataSource<
    CollectionDataSource.Section,
    CollectionDataSource.Item
> {

    // MARK: - Section and Item

    struct Section: Hashable {
        enum SectionType: Hashable {
            case top
            case regular
        }

        let type: SectionType
        let name: String
        let bgColor: UIColor
    }

    enum Item: Hashable {
        struct Article: Hashable {
            let title: String
            let subtitle: String
            let image: UIImage
        }

        case bestArticle(Article)
        case popularArticle(Article)
        case regularArticle(Article)
    }

    // MARK: - Init

    init(
        collectionView: UICollectionView,
        registrationFactory: CollectionRegistrationFactory
    ) {
        let bestArticleCellRegistration = registrationFactory.makeBestArticleCellRegistration()
        let popularArticleCellRegistration = registrationFactory.makePopularArticleCellRegistration()
        let regularArticleCellRegistration = registrationFactory.makeRegularArticleCellRegistration()

        super.init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .bestArticle(let bestArticle):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: bestArticleCellRegistration,
                        for: indexPath,
                        item: bestArticle
                    )
                case .popularArticle(let popularArticle):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: popularArticleCellRegistration,
                        for: indexPath,
                        item: popularArticle
                    )
                case .regularArticle(let regularArticle):
                    return collectionView.dequeueConfiguredReusableCell(
                        using: regularArticleCellRegistration,
                        for: indexPath,
                        item: regularArticle
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

        setupSnapshot()
    }

    // MARK: - Methods

    func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()

        let topSection = Section(type: .top, name: "Top", bgColor: .magenta)
        let animalsSection = Section(type: .regular, name: "Animals", bgColor: .green)
        let travelSection = Section(type: .regular, name: "Travel", bgColor: .yellow)

        let snapshotSections: [Section] = [topSection, animalsSection, travelSection]
        snapshot.appendSections(snapshotSections)

        snapshot.appendItems(
            [
                .bestArticle(
                    Item.Article(
                        title: "Match of the Week",
                        subtitle: "An instant classic with a dramatic finish",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                ),
                .popularArticle(
                    Item.Article(
                        title: "Rising Stars to Watch",
                        subtitle: "New names leading the scoreboard",
                        image: UIImage(systemName: "star.fill")!
                    )
                ),
                .popularArticle(
                    Item.Article(
                        title: "League Highlights",
                        subtitle: "Top moments from the weekend",
                        image: UIImage(systemName: "sparkles")!
                    )
                )
            ],
            toSection: topSection
        )

        snapshot.appendItems(
            [
                .regularArticle(
                    Item.Article(
                        title: "Wildlife Rescue Stories",
                        subtitle: "How volunteers help injured animals",
                        image: UIImage(systemName: "pawprint.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        title: "Life in the Rainforest",
                        subtitle: "The hidden world of canopy creatures",
                        image: UIImage(systemName: "leaf.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        title: "Ocean Giants",
                        subtitle: "Understanding whales and their migration",
                        image: UIImage(systemName: "drop.fill")!
                    )
                )
            ],
            toSection: animalsSection
        )

        snapshot.appendItems(
            [
                .regularArticle(
                    Item.Article(
                        title: "Weekend in Lisbon",
                        subtitle: "A guide to food, views, and trams",
                        image: UIImage(systemName: "airplane")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        title: "Mountain Escape",
                        subtitle: "Best trails for first-time hikers",
                        image: UIImage(systemName: "mountain.2.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        title: "City on Foot",
                        subtitle: "Walking tours through historic streets",
                        image: UIImage(systemName: "figure.walk")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        title: "Island Hopping",
                        subtitle: "Planning a stress-free ferry route",
                        image: UIImage(systemName: "ferry.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        title: "Northern Lights",
                        subtitle: "When and where to see the aurora",
                        image: UIImage(systemName: "sparkle")!
                    )
                )
            ],
            toSection: travelSection
        )

        apply(snapshot, animatingDifferences: true)
    }

}
