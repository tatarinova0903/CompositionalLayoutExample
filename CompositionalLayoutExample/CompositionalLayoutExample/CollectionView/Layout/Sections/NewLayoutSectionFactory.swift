import UIKit

enum NewLayoutSectionFactory {
    @MainActor
    static func build() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(1.0 / 3.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 3
        )
        group.interItemSpacing = .fixed(ItemsConstants.itemSpacing)

        let section = SportStatisticCollectionSectionFactory.build(from: group)

        let sectionBackground = NSCollectionLayoutDecorationItem.background(
            elementKind: SectionBackgroundView.elementKind
        )
        section.decorationItems = [sectionBackground]

        return section
    }

    private typealias ItemsConstants = SportStatisticCollectionLayoutItemsConstants
}
