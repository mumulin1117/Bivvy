import UIKit

final class ProductCategoryExplorationChipCell: UICollectionViewCell {
    static let reuseIdentifier = "ProductCategoryExplorationChipCell"

    private let productCategoryTitleLabel = UILabel()
    private let detailedReviewLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildProductCategoryLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: ProductCategoryExplorationItem, selected: Bool) {
        productCategoryTitleLabel.text = item.productHighlightTitle
        detailedReviewLabel.text = item.detailedReviewText
        detailedReviewLabel.isHidden = true
        contentView.backgroundColor = selected ? UIColor(red: 252 / 255, green: 69 / 255, blue: 126 / 255, alpha: 1) : UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        productCategoryTitleLabel.textColor = selected ? .white : UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)
    }

    private func buildProductCategoryLayout() {
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true

        productCategoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        productCategoryTitleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        productCategoryTitleLabel.textColor = CommunitySharingAuthTheme.trustedReviewInk
        productCategoryTitleLabel.textAlignment = .center
        productCategoryTitleLabel.adjustsFontSizeToFitWidth = true

        detailedReviewLabel.translatesAutoresizingMaskIntoConstraints = false
        detailedReviewLabel.font = .systemFont(ofSize: 12, weight: .medium)
        detailedReviewLabel.textColor = UIColor(red: 102 / 255, green: 91 / 255, blue: 125 / 255, alpha: 1)

        contentView.addSubview(productCategoryTitleLabel)
        contentView.addSubview(detailedReviewLabel)

        NSLayoutConstraint.activate([
            productCategoryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            productCategoryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            productCategoryTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            detailedReviewLabel.leadingAnchor.constraint(equalTo: productCategoryTitleLabel.leadingAnchor),
            detailedReviewLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -14),
            detailedReviewLabel.topAnchor.constraint(equalTo: productCategoryTitleLabel.bottomAnchor, constant: 4)
        ])
    }
}

typealias BivvyCategoryChipCell = ProductCategoryExplorationChipCell
