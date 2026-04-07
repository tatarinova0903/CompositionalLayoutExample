//
//  HockeyTeamLayoutSectionFactory.swift
//  CompositionalLayoutExample
//
//  Created by Daria Tatarinova on 07.04.2026.
//

import UIKit

enum HockeyTeamLayoutSectionFactory {
    @MainActor
    static func build() -> NSCollectionLayoutSection {
        let largeItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(1.0)
        )
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)

        let smallItemSize1 = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(0.725)
        )
        let smallItem1 = NSCollectionLayoutItem(layoutSize: smallItemSize1)

        let smallItemSize2 = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(0.275)
        )
        let smallItem2 = NSCollectionLayoutItem(layoutSize: smallItemSize2)

        let rightColumnSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(1.0)
        )
        let rightColumn = NSCollectionLayoutGroup.vertical(
            layoutSize: rightColumnSize,
            subitems: [smallItem1, smallItem2]
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

        return section
    }

    private typealias ItemsConstants = SportStatisticCollectionLayoutItemsConstants
}
