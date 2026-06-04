import UIKit

final class BivvyHomeUserCell: UICollectionViewCell {
    static let reuseIdentifier = "BivvyHomeUserCell"

    private let avatarView = UIImageView()
    private let nameLabel = UILabel()
    private let briefLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with user: BivvyRecommendationUser) {
        avatarView.image = UIImage(named: user.avatarName)
        nameLabel.text = user.name
        briefLabel.text = user.brief
    }

    private func buildLayout() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 18
        contentView.layer.masksToBounds = true

        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.contentMode = .scaleAspectFill
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 18

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        nameLabel.textColor = BivvyAuthTheme.ink

        briefLabel.translatesAutoresizingMaskIntoConstraints = false
        briefLabel.font = .systemFont(ofSize: 11, weight: .medium)
        briefLabel.textColor = BivvyAuthTheme.hotPink

        [avatarView, nameLabel, briefLabel].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 36),
            avatarView.heightAnchor.constraint(equalToConstant: 36),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            briefLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            briefLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            briefLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
}
