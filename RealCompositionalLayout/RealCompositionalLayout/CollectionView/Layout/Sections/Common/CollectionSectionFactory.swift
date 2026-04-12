import UIKit

@MainActor
enum CollectionSectionFactory {

    static func build(from group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = ItemsConstants.itemSpacing
        section.contentInsets = SectionConstants.sectionContentInsets

        let headerElement = buildHeader()
        section.boundarySupplementaryItems = [headerElement]
        section.supplementaryContentInsetsReference = .none

        return section
    }

    private static func buildHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .absolute(SectionConstants.sectionHeaderHeight)
        )
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        headerElement.pinToVisibleBounds = true
        headerElement.extendsBoundary = false
        return headerElement
    }
}

extension CollectionSectionFactory {

    private typealias ItemsConstants = CommonCollectionLayoutItemsConstants

    private enum SectionConstants {
        static var sectionHeaderHeight: CGFloat { 56.0 }
        static let sectionContentInsets = NSDirectionalEdgeInsets(
            top: sectionHeaderHeight,
            leading: 16.0,
            bottom: 16.0,
            trailing: 16.0
        )
    }

}

