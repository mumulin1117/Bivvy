import UIKit

final class BivvyCategoryChipCell: UICollectionViewCell {
    static let reuseIdentifier = "BivvyCategoryChipCell"

    private let titleLabel = UILabel()
    private let detailLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: BivvyCategoryItem, selected: Bool) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
        detailLabel.isHidden = true
        contentView.backgroundColor = selected ? UIColor(red: 252 / 255, green: 69 / 255, blue: 126 / 255, alpha: 1) : UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        titleLabel.textColor = selected ? .white : UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)
    }

    private func buildLayout() {
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = BivvyAuthTheme.ink
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true

        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.font = .systemFont(ofSize: 12, weight: .medium)
        detailLabel.textColor = UIColor(red: 102 / 255, green: 91 / 255, blue: 125 / 255, alpha: 1)

        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -14),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
        ])
    }
}
