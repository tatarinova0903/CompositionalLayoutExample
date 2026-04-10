import UIKit

final class PopularArticleCollectionViewCell: UICollectionViewCell {
    func configure(
        with article: CollectionDataSource.Item.Article,
        showsImage: Bool,
        showsSubtitle: Bool
    ) {
        var contentConfiguration: UIListContentConfiguration = showsSubtitle
            ? .subtitleCell()
            : .cell()

        contentConfiguration.text = article.title
        contentConfiguration.textProperties.numberOfLines = 2

        if showsSubtitle {
            contentConfiguration.secondaryText = article.subtitle
            contentConfiguration.secondaryTextProperties.numberOfLines = 2
        }

        if showsImage {
            contentConfiguration.image = article.image
            contentConfiguration.imageProperties.maximumSize = CGSize(width: 48.0, height: 48.0)
            contentConfiguration.imageProperties.cornerRadius = 6.0
        }

        self.contentConfiguration = contentConfiguration

        var backgroundConfiguration = UIBackgroundConfiguration.listCell()
        backgroundConfiguration.backgroundColor = .secondarySystemBackground
        self.backgroundConfiguration = backgroundConfiguration
    }
}
