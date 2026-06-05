import UIKit

final class BivvyHomeFindCell: UICollectionViewCell {
    static let reuseIdentifier = "BivvyHomeFindCell"

    private let imageView = UIImageView()
    private let fadeView = BivvyGradientView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
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
        subtitleLabel.text = "  \(item.category ?? item.subtitle)  "
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        onReport = nil
    }

    private func buildLayout() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 18
        contentView.layer.masksToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        fadeView.translatesAutoresizingMaskIntoConstraints = false
        fadeView.isUserInteractionEnabled = false
        fadeView.colors = [
            UIColor.white.withAlphaComponent(0.02),
            UIColor.white.withAlphaComponent(0.72)
        ]
        fadeView.startPoint = CGPoint(x: 0.5, y: 0.2)
        fadeView.endPoint = CGPoint(x: 0.5, y: 1.0)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = makeCardTitleFont()
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.82

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = .systemFont(ofSize: 11, weight: .heavy)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.minimumScaleFactor = 0.75
        subtitleLabel.backgroundColor = BivvyAuthTheme.hotPink.withAlphaComponent(0.9)
        subtitleLabel.layer.cornerRadius = 14
        subtitleLabel.layer.masksToBounds = true

        reportButton.translatesAutoresizingMaskIntoConstraints = false
        reportButton.setImage(UIImage(systemName: "flag.fill"), for: .normal)
        reportButton.tintColor = BivvyAuthTheme.hotPink
        reportButton.backgroundColor = UIColor.white.withAlphaComponent(0.88)
        reportButton.layer.cornerRadius = 16
        reportButton.imageView?.contentMode = .scaleAspectFit
        reportButton.addTarget(self, action: #selector(reportTapped), for: .touchUpInside)

        [imageView, fadeView, subtitleLabel, titleLabel, reportButton].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            fadeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fadeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fadeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            fadeView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.46),

            subtitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 28),
            subtitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 86),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: reportButton.leadingAnchor, constant: -8),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),

            reportButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            reportButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            reportButton.widthAnchor.constraint(equalToConstant: 32),
            reportButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func makeCardTitleFont() -> UIFont {
        let baseFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        guard let descriptor = baseFont.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) else {
            return baseFont
        }
        return UIFont(descriptor: descriptor, size: 20)
    }

    @objc private func reportTapped() {
        onReport?()
    }
}
