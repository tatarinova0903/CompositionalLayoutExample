import UIKit

final class PopularArticleCollectionViewCell: UICollectionViewCell {
    func configure(
        with article: Article
    ) {
        var contentConfiguration: UIListContentConfiguration = .cell()

        contentConfiguration.text = article.title
        contentConfiguration.textProperties.numberOfLines = 3

        self.contentConfiguration = contentConfiguration

        var backgroundConfiguration = UIBackgroundConfiguration.listCell()
        backgroundConfiguration.backgroundColor = .secondarySystemBackground
        self.backgroundConfiguration = backgroundConfiguration
    }
}
