import UIKit

final class CollectionDataSource: UICollectionViewDiffableDataSource<
    CollectionDataSource.Section,
    CollectionDataSource.Item
> {

    // MARK: - Section and Item

    struct Section: Hashable {
        enum SectionType: Hashable {
            case top(UIColor)
            case regular(UIColor)
        }

        let type: SectionType
        let name: String
    }

    enum Item: Hashable {
        struct Article: Hashable {
            let sphere: String
            let title: String
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

        let topSection = Section(type: .top(.magenta), name: "Popular Today")
        let animalsSection = Section(type: .regular(.green), name: "Recommended to Read")
        let travelSection = Section(type: .regular(.yellow), name: "Lifestyle")

        let snapshotSections: [Section] = [topSection, animalsSection, travelSection]
        snapshot.appendSections(snapshotSections)

        snapshot.appendItems(
            [
                .bestArticle(
                    Item.Article(
                        sphere: "Psychology",
                        title: "Why Your Brain Sabotages Your Goals",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                ),
                .popularArticle(
                    Item.Article(
                        sphere: "Astrophysics",
                        title: "Dark Matter: 50 Years of Searching",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                ),
                .popularArticle(
                    Item.Article(
                        sphere: "Medicine",
                        title: "How Gut Microbiome Controls Your Mood",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                )
            ],
            toSection: topSection
        )

        snapshot.appendItems(
            [
                .regularArticle(
                    Item.Article(
                        sphere: "Architecture",
                        title: "Architecture of Future Cities",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        sphere: "Business",
                        title: "Why Better Products Lose the Market",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        sphere: "IT",
                        title: "Quantum Computers vs Classic Encryption",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                )
            ],
            toSection: animalsSection
        )

        snapshot.appendItems(
            [
                .regularArticle(
                    Item.Article(
                        sphere: "Sociology",
                        title: "Loneliness as an Epidemic of XXI Century",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        sphere: "Ecology",
                        title: "How Climate Change Rewrites Wine Maps",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        sphere: "Health",
                        title: "Sleep as a Superpower: 8 Hours Inside",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        sphere: "Psychology",
                        title: "Why We Forgot How to Be Bored",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                ),
                .regularArticle(
                    Item.Article(
                        sphere: "Medicine",
                        title: "The Silent Threat of Chronic Inflammation",
                        image: UIImage(systemName: "trophy.fill")!
                    )
                )
            ],
            toSection: travelSection
        )

        apply(snapshot, animatingDifferences: true)
    }

}
