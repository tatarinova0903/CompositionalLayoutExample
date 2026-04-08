import UIKit

final class CollectionLayout: UICollectionViewCompositionalLayout {

    typealias DataSource = CollectionDataSource
    typealias SectionProvider = (Int) -> DataSource.Section?

    private let sectionProvider: SectionProvider

    init(
        sectionProvider: @escaping SectionProvider
    ) {
        self.sectionProvider = sectionProvider

        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        configuration.interSectionSpacing = CommonCollectionLayoutItemsConstants.itemSpacing

        super.init(
            sectionProvider: { sectionIndex, _ in
                let section = sectionProvider(sectionIndex)
                switch section?.type {
                case .top:
                    return TopLayoutSectionFactory.build()
                case .regular:
                    return NewLayoutSectionFactory.build()
                case .none:
                    return nil
                }
            },
            configuration: configuration
        )

        register(
            SectionBackgroundView.self,
            forDecorationViewOfKind: SectionBackgroundView.elementKind
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Section Background

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        return attributes?.map { attr in
            guard attr.representedElementCategory == .decorationView else {
                return attr
            }
            return getDecorationAttributes(from: attr)
        }
    }

    private func getDecorationAttributes(
        from attr: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        guard let elementKind = attr.representedElementKind else {
            return attr
        }
        guard let section = sectionProvider(attr.indexPath.section) else {
            return attr
        }
        switch (elementKind, section.type) {
        case (SectionBackgroundView.elementKind, .top(let background)),
            (SectionBackgroundView.elementKind, .regular(let background)):
            return getAttributesForStatisticSection(from: attr, with: background)
        default:
            return attr
        }
    }

    private func getAttributesForStatisticSection(
        from attr: UICollectionViewLayoutAttributes,
        with backgroundColor: UIColor
    ) -> SectionBackgroundLayoutAttributes {
        let custom = SectionBackgroundLayoutAttributes(
            forDecorationViewOfKind: SectionBackgroundView.elementKind,
            with: attr.indexPath
        )
        custom.frame = attr.frame
        custom.zIndex = -1
        custom.color = backgroundColor
        return custom
    }
}
