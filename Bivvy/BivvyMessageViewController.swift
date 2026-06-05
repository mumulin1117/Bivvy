import UIKit

final class ConversationStarterMessageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildConversationStarterLayout()
    }

    private func buildConversationStarterLayout() {
        view.backgroundColor = .white

        let conversationStarterBackground = ProductCurationGradientView()
        conversationStarterBackground.translatesAutoresizingMaskIntoConstraints = false
        conversationStarterBackground.curatedListColors = [
            UIColor(red: 255 / 255, green: 205 / 255, blue: 215 / 255, alpha: 1),
            UIColor(red: 255 / 255, green: 246 / 255, blue: 251 / 255, alpha: 1),
            UIColor.white
        ]
        conversationStarterBackground.productCurationStartPoint = CGPoint(x: 0, y: 0)
        conversationStarterBackground.productCurationEndPoint = CGPoint(x: 0.82, y: 0.48)

        let communityHubBackButton = UIButton(type: .system)
        communityHubBackButton.translatesAutoresizingMaskIntoConstraints = false
        communityHubBackButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        communityHubBackButton.tintColor = .black
        communityHubBackButton.addTarget(self, action: #selector(closeConversationStarterPage), for: .touchUpInside)

        let communityBoardTitleLabel = UILabel()
        communityBoardTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        communityBoardTitleLabel.text = "Message"
        communityBoardTitleLabel.font = .systemFont(ofSize: 28, weight: .regular)
        communityBoardTitleLabel.textColor = .black
        communityBoardTitleLabel.textAlignment = .center

       
        let latestNewsTitleLabel = UILabel()
        latestNewsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        latestNewsTitleLabel.text = "Latest News"
        latestNewsTitleLabel.font = CommunitySharingAuthTheme.productShowcaseTitleFont(size: 30)
        latestNewsTitleLabel.textColor = .black

        let emptyConversationCard = UIView()
        emptyConversationCard.translatesAutoresizingMaskIntoConstraints = false
        emptyConversationCard.backgroundColor = .white
        emptyConversationCard.layer.cornerRadius = 26
        emptyConversationCard.layer.shadowColor = UIColor.black.cgColor
        emptyConversationCard.layer.shadowOpacity = 0.06
        emptyConversationCard.layer.shadowRadius = 18
        emptyConversationCard.layer.shadowOffset = CGSize(width: 0, height: 8)

        let emptyConversationLabel = UILabel()
        emptyConversationLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyConversationLabel.text = BivvyStringVault.noFriend
        emptyConversationLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        emptyConversationLabel.textColor = UIColor(red: 145 / 255, green: 145 / 255, blue: 145 / 255, alpha: 1)
        emptyConversationLabel.textAlignment = .center

        view.addSubview(conversationStarterBackground)
        view.addSubview(communityHubBackButton)
        view.addSubview(communityBoardTitleLabel)
       
        view.addSubview(latestNewsTitleLabel)
        view.addSubview(emptyConversationCard)
        emptyConversationCard.addSubview(emptyConversationLabel)

        NSLayoutConstraint.activate([
            conversationStarterBackground.topAnchor.constraint(equalTo: view.topAnchor),
            conversationStarterBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conversationStarterBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conversationStarterBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            communityHubBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            communityHubBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            communityHubBackButton.widthAnchor.constraint(equalToConstant: 36),
            communityHubBackButton.heightAnchor.constraint(equalToConstant: 36),

            communityBoardTitleLabel.centerYAnchor.constraint(equalTo: communityHubBackButton.centerYAnchor),
            communityBoardTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            communityBoardTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: communityHubBackButton.trailingAnchor, constant: 20),

            latestNewsTitleLabel.topAnchor.constraint(equalTo: communityBoardTitleLabel.bottomAnchor, constant: 28),
            latestNewsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            latestNewsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            emptyConversationCard.topAnchor.constraint(equalTo: latestNewsTitleLabel.bottomAnchor, constant:12),
            emptyConversationCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            emptyConversationCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            emptyConversationCard.heightAnchor.constraint(equalToConstant: 80),

            emptyConversationLabel.leadingAnchor.constraint(equalTo: emptyConversationCard.leadingAnchor, constant: 20),
            emptyConversationLabel.trailingAnchor.constraint(equalTo: emptyConversationCard.trailingAnchor, constant: -20),
            emptyConversationLabel.centerYAnchor.constraint(equalTo: emptyConversationCard.centerYAnchor)
        ])
    }


    @objc private func closeConversationStarterPage() {
        navigationController?.popViewController(animated: true)
    }

   
}

typealias BivvyMessageViewController = ConversationStarterMessageViewController
