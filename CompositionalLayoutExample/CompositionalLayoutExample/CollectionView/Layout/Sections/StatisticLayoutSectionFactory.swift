import UIKit

enum StatisticLayoutSectionFactory {
    @MainActor
    static func build() -> NSCollectionLayoutSection {
        // Items
        let largeItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(1.0)
        )
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)

        let smallItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(0.5)
        )
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)

        // Right Column
        let rightColumnSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(1.0)
        )
        let rightColumn = NSCollectionLayoutGroup.vertical(
            layoutSize: rightColumnSize,
            repeatingSubitem: smallItem,
            count: 2
        )
        rightColumn.interItemSpacing = .fixed(ItemsConstants.itemSpacing)

        // Group
        let groupSubitems = [largeItem, rightColumn]
        let groupSubitemsCount = CGFloat(groupSubitems.count)
        let groupWidth = ItemsConstants.itemWidth * groupSubitemsCount + ItemsConstants.itemSpacing * (groupSubitemsCount - 1)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(groupWidth),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: groupSubitems
        )
        group.interItemSpacing = .fixed(ItemsConstants.itemSpacing)

        // Section
        let section = SportStatisticCollectionSectionFactory.build(from: group)

//        let sectionBackground = NSCollectionLayoutDecorationItem.background(
//            elementKind: StatisticSectionBackgroundView.elementKind
//        )
//        section.decorationItems = [sectionBackground]

        return section
    }

    private typealias ItemsConstants = SportStatisticCollectionLayoutItemsConstants
}
