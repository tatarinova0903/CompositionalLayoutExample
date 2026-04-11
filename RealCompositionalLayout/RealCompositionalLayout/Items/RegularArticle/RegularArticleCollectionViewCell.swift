import UIKit
import SwiftUI

final class RegularArticleCollectionViewCell: UICollectionViewCell {
    func configure(
        with article: Article
    ) {
        contentConfiguration = UIHostingConfiguration {
            RegularArticleView(article: article)
        }
        .margins(.all, 0.0)
    }
}

private struct RegularArticleView: View {

    let article: Article

    var body: some View {
        VStack {
            Spacer()
            Text(article.title)
                .foregroundStyle(Color.white)
                .font(.caption)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .bottom)
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
