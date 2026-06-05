import UIKit

final class BivvyHomeUserCell: UICollectionViewCell {
    static let reuseIdentifier = "BivvyHomeUserCell"

    private let avatarView = UIImageView()
    private let nameLabel = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with user: BivvyRecommendationUser) {
        BivvyRemoteImageLoader.shared.load(user.avatarURL, into: avatarView, placeholder: UIImage(named: user.avatarName))
        nameLabel.text = user.name
       
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
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        nameLabel.textColor = UIColor.white
        nameLabel.backgroundColor = UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1)

        [avatarView, nameLabel].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}
