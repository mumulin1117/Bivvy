import UIKit

final class UserRecommendationCardCell: UICollectionViewCell {
    static let reuseIdentifier = "UserRecommendationCardCell"

    private let contentCreatorAvatarView = UIImageView()
    private let contentCreatorNameLabel = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUserRecommendationLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with user: UserRecommendationProfile) {
        BivvyRemoteImageLoader.shared.load(user.contentCreatorAvatarURL, into: contentCreatorAvatarView, placeholder: UIImage(named: user.contentCreatorAvatarName))
        contentCreatorNameLabel.text = user.contentCreatorName
       
    }

    private func buildUserRecommendationLayout() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 18
        contentView.layer.masksToBounds = true

        contentCreatorAvatarView.translatesAutoresizingMaskIntoConstraints = false
        contentCreatorAvatarView.contentMode = .scaleAspectFill
        contentCreatorAvatarView.clipsToBounds = true
        contentCreatorAvatarView.layer.cornerRadius = 18
        contentCreatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentCreatorNameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        contentCreatorNameLabel.textColor = UIColor.white
        contentCreatorNameLabel.backgroundColor = UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1)

        [contentCreatorAvatarView].forEach(contentView.addSubview)
        contentView.addSubview(contentCreatorNameLabel)
        NSLayoutConstraint.activate([
            contentCreatorAvatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentCreatorAvatarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentCreatorAvatarView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentCreatorAvatarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentCreatorNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentCreatorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            contentCreatorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:0),
            contentCreatorNameLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}

typealias BivvyHomeUserCell = UserRecommendationCardCell
