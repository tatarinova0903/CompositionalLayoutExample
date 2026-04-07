import UIKit

final class SectionBackgroundView: UICollectionReusableView {

    static let elementKind = String(reflecting: SectionBackgroundView.self)

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let attrs = layoutAttributes as? SectionBackgroundLayoutAttributes,
              let color = attrs.color
        else {
            return
        }
        self.backgroundColor = color
    }
}

// MARK: - UICollectionViewLayoutAttributes

final class SectionBackgroundLayoutAttributes: UICollectionViewLayoutAttributes {
    nonisolated(unsafe) var color: UIColor?

    override func copy() -> Any {
        let copy = super.copy()
        guard let copy = copy as? SectionBackgroundLayoutAttributes else {
            return copy
        }
        copy.color = self.color
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? SectionBackgroundLayoutAttributes,
              object.color == self.color
        else {
            return false
        }
        return super.isEqual(object)
    }
}
