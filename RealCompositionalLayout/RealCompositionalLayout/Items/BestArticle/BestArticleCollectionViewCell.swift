import UIKit
import SwiftUI

final class BestArticleCollectionViewCell: UICollectionViewCell {
    func configure(
        with article: Article
    ) {
        contentConfiguration = UIHostingConfiguration {
            BestArticleCollectionView(article: article)
        }
    }
}

private struct BestArticleCollectionView: View {

    let article: Article

    var body: some View {
        VStack {
            HStack {
                Spacer()
                PopularLabelView()
            }

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
        }
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }

}


private struct PopularLabelView: View {

    var body: some View {
        HStack(spacing: 4.0) {
            Image(.trending)
                .resizable()
                .frame(width: 12.0, height: 12.0)

            Text("Popular")
                .font(.caption)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4.0)
        .padding(.horizontal, 8.0)
        .background(Color.white)
        .clipShape(.capsule)
    }

}
