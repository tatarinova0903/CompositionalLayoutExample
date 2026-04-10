import UIKit

final class RegularArticleCollectionViewCell: UICollectionViewCell {
    func configure(
        with article: CollectionDataSource.Item.Article
    ) {
        var contentConfiguration: UIListContentConfiguration = .cell()

        contentConfiguration.text = article.title
        contentConfiguration.textProperties.numberOfLines = 3

        contentConfiguration.image = article.image
        contentConfiguration.imageProperties.maximumSize = CGSize(width: 48.0, height: 48.0)
        contentConfiguration.imageProperties.cornerRadius = 6.0

        self.contentConfiguration = contentConfiguration

        var backgroundConfiguration = UIBackgroundConfiguration.listCell()
        backgroundConfiguration.backgroundColor = .secondarySystemBackground
        self.backgroundConfiguration = backgroundConfiguration
    }
}
