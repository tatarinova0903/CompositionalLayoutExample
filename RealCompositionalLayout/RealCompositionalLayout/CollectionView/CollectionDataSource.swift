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

        let popularSection = Section(type: .top(.lightOrange), name: "Popular Today")
        let travelSection = Section(type: .regular(.lightBlue), name: "Travel")
        let foodSection = Section(type: .regular(.lightGreen), name: "Food")

        let snapshotSections: [Section] = [popularSection, travelSection, foodSection]
        snapshot.appendSections(snapshotSections)

        snapshot.appendItems(
            [
                .bestArticle(
                    Article(
                        sphere: "Psychology",
                        title: "Why Your Brain Sabotages Your Goals",
                        image: .brain
                    )
                ),
                .popularArticle(
                    Article(
                        sphere: "Astrophysics",
                        title: "Dark Matter: 50 Years of Searching",
                        image: .cosmos
                    )
                ),
                .popularArticle(
                    Article(
                        sphere: "Medicine",
                        title: "How Gut Microbiome Controls Your Mood",
                        image: .gut
                    )
                ),
                .bestArticle(
                    Article(
                        sphere: "Architecture",
                        title: "Architecture of Future Cities",
                        image: .architecture
                    )
                ),
                .popularArticle(
                    Article(
                        sphere: "Business",
                        title: "Why Better Products Lose the Market",
                        image: .marketing
                    )
                ),
                .popularArticle(
                    Article(
                        sphere: "IT",
                        title: "Quantum Computers vs Classic Encryption",
                        image: .it
                    )
                )
            ],
            toSection: popularSection
        )

        snapshot.appendItems(
            [
                .regularArticle(
                    Article(
                        sphere: "Travel",
                        title: "Hidden Gems: 10 Underrated Destinations You Need to Visit",
                        image: .travel1
                    )
                ),
                .regularArticle(
                    Article(
                        sphere: "Travel",
                        title: "Solo Travel Guide: How to Explore the World on Your Own",
                        image: .travel2
                    )
                ),
                .regularArticle(
                    Article(
                        sphere: "Travel",
                        title: "Budget Travel Hacks: See More, Spend Less",
                        image: .travel3
                    )
                ),
                .regularArticle(
                    Article(
                        sphere: "Travel",
                        title: "Off the Beaten Path: Adventures Beyond Tourist Traps",
                        image: .travel4
                    )
                ),
                .regularArticle(
                    Article(
                        sphere: "Travel",
                        title: "The Art of Slow Travel: Why Less Is More",
                        image: .travel5
                    )
                )
            ],
            toSection: travelSection
        )

        snapshot.appendItems(
            [
                .regularArticle(
                    Article(
                        sphere: "Food",
                        title: "Street Food Around the World: The Ultimate Guide",
                        image: .streetFood
                    )
                ),
                .regularArticle(
                    Article(
                        sphere: "Food",
                        title: "Farm to Table: Why Local Food Tastes Better",
                        image: .farm
                    )
                ),
                .regularArticle(
                    Article(
                        sphere: "Food",
                        title: "The Art of Fermentation: Ancient Techniques for Modern Kitchens",
                        image: .fermentation
                    )
                ),
                .regularArticle(
                    Article(
                        sphere: "Food",
                        title: "Plant-Based Diet: How to Make the Switch Without Sacrificing Taste",
                        image: .diet
                    )
                ),
                .regularArticle(
                    Article(
                        sphere: "Food",
                        title: "Secret Ingredients: What Top Chefs Never Tell You",
                        image: .chef
                    )
                ),
                .regularArticle(
                    Article(
                        sphere: "Food",
                        title: "Food Tourism: The Best Culinary Destinations in the World",
                        image: .foodTravel
                    )
                )
            ],
            toSection: foodSection
        )

        apply(snapshot, animatingDifferences: true)
    }

}
