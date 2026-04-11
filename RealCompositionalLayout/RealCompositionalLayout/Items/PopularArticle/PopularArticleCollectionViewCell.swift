import UIKit
import SwiftUI

final class PopularArticleCollectionViewCell: UICollectionViewCell {
    func configure(
        with article: Article
    ) {
        contentConfiguration = UIHostingConfiguration {
            PopularArticleView(article: article)
        }
        .margins(.all, 0.0)
    }
}

private struct PopularArticleView: View {

    let article: Article

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 8.0) {
                Text(article.sphere)
                    .foregroundStyle(Color.white)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8.0)
                    .padding(.vertical, 4.0)
                    .background(.ultraThinMaterial)
                    .clipShape(.capsule)

                Text(article.title)
                    .foregroundStyle(Color.white)
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .background {
            Image(article.image)
                .resizable()
                .scaledToFill()
                .overlay {
                    LinearGradient(colors: [.clear, .black.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }

}
