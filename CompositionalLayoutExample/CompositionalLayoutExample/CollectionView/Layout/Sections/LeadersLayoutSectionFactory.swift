//
//  LeadersLayoutSectionFactory.swift
//  CompositionalLayoutExample
//
//  Created by Daria Tatarinova on 07.04.2026.
//

import UIKit

enum LeadersLayoutSectionFactory {
    @MainActor
    static func build() -> NSCollectionLayoutSection {
        let leaderItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(1.0 / 3.0)
        )
        let leaderItem = NSCollectionLayoutItem(layoutSize: leaderItemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(ItemsConstants.itemWidth),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: leaderItem,
            count: 3
        )
        group.interItemSpacing = .fixed(ItemsConstants.itemSpacing)

        let section = SportStatisticCollectionSectionFactory.build(from: group)

        return section
    }

    private typealias ItemsConstants = SportStatisticCollectionLayoutItemsConstants
}
