import UIKit

final class SportStatisticCollectionLayout: UICollectionViewCompositionalLayout {

    // MARK: - Internal Types

    typealias DataSource = SportStatisticCollectionDataSource
    typealias SectionProvider = (Int) -> DataSource.Section?

    // MARK: - Internal Init

    init(
        sectionProvider: @escaping SectionProvider
    ) {
        self.sectionProvider = sectionProvider

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        configuration.interSectionSpacing = ItemsConstants.itemSpacing

        super.init(
            sectionProvider: { sectionIndex, _ in
                let section = sectionProvider(sectionIndex)
                switch section?.type {
                case .top:
                    return TopLayoutSectionFactory.build()
                case .new:
                    return NewLayoutSectionFactory.build()
                case .none:
                    return nil
                }
            },
            configuration: configuration
        )

//        register(
//            StatisticSectionBackgroundView.self,
//            forDecorationViewOfKind: StatisticSectionBackgroundView.elementKind
//        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Methods

    // MARK: - Section Background

//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let expandedRect = rect.expanded(by: Constants.backgroundExpansion)
//        let attributes = super.layoutAttributesForElements(in: expandedRect)
//        return attributes?.map { attr in
//            guard attr.representedElementCategory == .decorationView else {
//                return attr
//            }
//            return getDecorationAttributes(from: attr)
//        }
//    }

    // MARK: - Private Types

    private typealias ItemsConstants = SportStatisticCollectionLayoutItemsConstants

    // MARK: - Private Properties

    private let sectionProvider: SectionProvider

    // MARK: - Private Methods

//    private func getDecorationAttributes(
//        from attr: UICollectionViewLayoutAttributes
//    ) -> UICollectionViewLayoutAttributes {
//        guard let elementKind = attr.representedElementKind else {
//            return attr
//        }
//        guard let section = sectionProvider(attr.indexPath.section) else {
//            return attr
//        }
//        switch (elementKind, section.type) {
//        case (StatisticSectionBackgroundView.elementKind, .statistic(let background)):
//            return getAttributesForStatisticSection(from: attr, with: background)
//        default:
//            return attr
//        }
//    }
//
//    private func getAttributesForStatisticSection(
//        from attr: UICollectionViewLayoutAttributes,
//        with background: DataSource.Section.SectionType.Background
//    ) -> StatisticSectionBackgroundLayoutAttributes {
//        let custom = StatisticSectionBackgroundLayoutAttributes(
//            forDecorationViewOfKind: StatisticSectionBackgroundView.elementKind,
//            with: attr.indexPath
//        )
//        let expandedFrame = attr.frame.expanded(by: Constants.backgroundExpansion)
//        custom.frame = expandedFrame
//        custom.zIndex = -1
//        custom.configure(
//            firstColor: UIColor(background.firstTeamColor),
//            secondColor: UIColor(background.secondTeamColor)
//        )
//        return custom
//    }
}

// MARK: - CGRect + NSDirectionalEdgeInsets

extension CGRect {
    fileprivate func expanded(by insets: NSDirectionalEdgeInsets) -> CGRect {
        CGRect(
            x: minX - insets.leading,
            y: minY - insets.top,
            width: width + insets.leading + insets.trailing,
            height: height + insets.top + insets.bottom
        )
    }
}
