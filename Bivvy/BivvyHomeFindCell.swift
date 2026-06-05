import UIKit

final class BivvyHomeFindCell: UICollectionViewCell {
    static let reuseIdentifier = "BivvyHomeFindCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let likeLabel = UILabel()
    private let saveLabel = UILabel()
    private let reportButton = UIButton(type: .system)
    var onReport: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: BivvyFindItem) {
        imageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        likeLabel.text = "Like \(item.likes)"
        saveLabel.text = "Save \(item.saves)"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onReport = nil
    }

    private func buildLayout() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.shadowRadius = 14
        contentView.layer.shadowOffset = CGSize(width: 0, height: 8)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = BivvyAuthTheme.ink
        titleLabel.numberOfLines = 2

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        subtitleLabel.textColor = BivvyAuthTheme.hotPink

        let metricStack = UIStackView(arrangedSubviews: [likeLabel, saveLabel])
        metricStack.translatesAutoresizingMaskIntoConstraints = false
        metricStack.axis = .horizontal
        metricStack.spacing = 10
        metricStack.distribution = .fillEqually

        [likeLabel, saveLabel].forEach {
            $0.font = .systemFont(ofSize: 11, weight: .medium)
            $0.textColor = UIColor(red: 113 / 255, green: 107 / 255, blue: 124 / 255, alpha: 1)
            $0.adjustsFontSizeToFitWidth = true
        }

        reportButton.translatesAutoresizingMaskIntoConstraints = false
        reportButton.setTitle("Report", for: .normal)
        reportButton.setTitleColor(BivvyAuthTheme.hotPink, for: .normal)
        reportButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        reportButton.contentHorizontalAlignment = .right
        reportButton.addTarget(self, action: #selector(reportTapped), for: .touchUpInside)

        [imageView, titleLabel, subtitleLabel, metricStack, reportButton].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.05),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            metricStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            metricStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            metricStack.trailingAnchor.constraint(equalTo: reportButton.leadingAnchor, constant: -8),
            metricStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),

            reportButton.centerYAnchor.constraint(equalTo: metricStack.centerYAnchor),
            reportButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            reportButton.widthAnchor.constraint(equalToConstant: 58),
            reportButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    @objc private func reportTapped() {
        onReport?()
    }
}
