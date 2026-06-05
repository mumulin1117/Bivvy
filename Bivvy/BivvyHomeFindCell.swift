import UIKit

final class ProductShowcaseFindCell: UICollectionViewCell {
    static let reuseIdentifier = "ProductShowcaseFindCell"

    private let productShowcaseImageView = UIImageView()
    private let productHighlightFadeView = ProductCurationGradientView()
    private let productHighlightTitleLabel = UILabel()
    private let productCategoryTagLabel = UILabel()
    private let trustedReviewReportButton = UIButton(type: .system)
    var trustedReviewReportAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildProductShowcaseLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: ProductShowcaseFindItem) {
        productShowcaseImageView.image = UIImage.bivvyFindImage(namedOrPath: item.productShowcaseImageName)
        productHighlightTitleLabel.text = item.productHighlightTitle
        productCategoryTagLabel.text = "  \(item.productCategoryName ?? item.productCategorySubtitle)  "
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productShowcaseImageView.image = nil
        trustedReviewReportAction = nil
    }

    private func buildProductShowcaseLayout() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 18
        contentView.layer.masksToBounds = true

        productShowcaseImageView.translatesAutoresizingMaskIntoConstraints = false
        productShowcaseImageView.contentMode = .scaleAspectFill
        productShowcaseImageView.clipsToBounds = true

        productHighlightFadeView.translatesAutoresizingMaskIntoConstraints = false
        productHighlightFadeView.isUserInteractionEnabled = false
        productHighlightFadeView.curatedListColors = [
            UIColor.white.withAlphaComponent(0.02),
            UIColor.white.withAlphaComponent(0.72)
        ]
        productHighlightFadeView.productCurationStartPoint = CGPoint(x: 0.5, y: 0.2)
        productHighlightFadeView.productCurationEndPoint = CGPoint(x: 0.5, y: 1.0)

        productHighlightTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        productHighlightTitleLabel.font = makeProductHighlightTitleFont()
        productHighlightTitleLabel.textColor = .black
        productHighlightTitleLabel.numberOfLines = 2
        productHighlightTitleLabel.adjustsFontSizeToFitWidth = true
        productHighlightTitleLabel.minimumScaleFactor = 0.82

        productCategoryTagLabel.translatesAutoresizingMaskIntoConstraints = false
        productCategoryTagLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        productCategoryTagLabel.textColor = .white
        productCategoryTagLabel.textAlignment = .center
        productCategoryTagLabel.adjustsFontSizeToFitWidth = true
        productCategoryTagLabel.minimumScaleFactor = 0.75
        productCategoryTagLabel.backgroundColor = CommunitySharingAuthTheme.favoriteFindPink.withAlphaComponent(0.9)
        productCategoryTagLabel.layer.cornerRadius = 14
        productCategoryTagLabel.layer.masksToBounds = true

        trustedReviewReportButton.translatesAutoresizingMaskIntoConstraints = false
        trustedReviewReportButton.setImage(UIImage(systemName: "flag.fill"), for: .normal)
        trustedReviewReportButton.tintColor = CommunitySharingAuthTheme.favoriteFindPink
        trustedReviewReportButton.backgroundColor = UIColor.white.withAlphaComponent(0.88)
        trustedReviewReportButton.layer.cornerRadius = 16
        trustedReviewReportButton.imageView?.contentMode = .scaleAspectFit
        trustedReviewReportButton.addTarget(self, action: #selector(openTrustedReviewReport), for: .touchUpInside)

        [productShowcaseImageView, productHighlightFadeView, productCategoryTagLabel, productHighlightTitleLabel, trustedReviewReportButton].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            productShowcaseImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productShowcaseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productShowcaseImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productShowcaseImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            productHighlightFadeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productHighlightFadeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productHighlightFadeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productHighlightFadeView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.46),

            productCategoryTagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            productCategoryTagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            productCategoryTagLabel.heightAnchor.constraint(equalToConstant: 28),
            productCategoryTagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 86),
            productCategoryTagLabel.trailingAnchor.constraint(lessThanOrEqualTo: trustedReviewReportButton.leadingAnchor, constant: -8),

            productHighlightTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            productHighlightTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            productHighlightTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            trustedReviewReportButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            trustedReviewReportButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            trustedReviewReportButton.widthAnchor.constraint(equalToConstant: 32),
            trustedReviewReportButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func makeProductHighlightTitleFont() -> UIFont {
        let productHighlightBaseFont = UIFont.systemFont(ofSize: 15, weight: .bold)
        guard let productHighlightDescriptor = productHighlightBaseFont.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) else {
            return productHighlightBaseFont
        }
        return UIFont(descriptor: productHighlightDescriptor, size: 20)
    }

    @objc private func openTrustedReviewReport() {
        trustedReviewReportAction?()
    }
}

typealias BivvyHomeFindCell = ProductShowcaseFindCell
