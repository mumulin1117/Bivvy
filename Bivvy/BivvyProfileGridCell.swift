import UIKit

final class ContentCreatorCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "ContentCreatorCollectionCell"

    private let productShowcaseImageView = UIImageView()
    private let productHighlightTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildContentCreatorLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with contentCreatorItem: ContentCreatorProfileItem) {
        BivvyRemoteImageLoader.shared.load(contentCreatorItem.productShowcaseImageURL, into: productShowcaseImageView, placeholder: UIImage(named: contentCreatorItem.productShowcaseImageName))
        productHighlightTitleLabel.text = contentCreatorItem.productHighlightTitle
    }

    private func buildContentCreatorLayout() {
        contentView.backgroundColor = .clear

        productShowcaseImageView.translatesAutoresizingMaskIntoConstraints = false
        productShowcaseImageView.contentMode = .scaleAspectFill
        productShowcaseImageView.clipsToBounds = true
        productShowcaseImageView.layer.cornerRadius = 18

        productHighlightTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        productHighlightTitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        productHighlightTitleLabel.textColor = .black
        productHighlightTitleLabel.backgroundColor = .clear
        productHighlightTitleLabel.textAlignment = .left
        productHighlightTitleLabel.numberOfLines = 2

        contentView.addSubview(productShowcaseImageView)
        contentView.addSubview(productHighlightTitleLabel)

        NSLayoutConstraint.activate([
            productShowcaseImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productShowcaseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productShowcaseImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productShowcaseImageView.heightAnchor.constraint(equalTo: productShowcaseImageView.widthAnchor, multiplier: 1.05),

            productHighlightTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productHighlightTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productHighlightTitleLabel.topAnchor.constraint(equalTo: productShowcaseImageView.bottomAnchor, constant: 8),
            productHighlightTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
}

typealias BivvyProfileGridCell = ContentCreatorCollectionCell
