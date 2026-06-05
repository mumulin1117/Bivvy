import UIKit

final class TrustedReviewEULAViewController: UIViewController {
    var trustedReviewAccepted: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildTrustedReviewLayout()
    }

    private func buildTrustedReviewLayout() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.48)

        let authenticReviewBackground = UIImageView(image: UIImage(named: "bivvy_auth_login_hero"))
        authenticReviewBackground.translatesAutoresizingMaskIntoConstraints = false
        authenticReviewBackground.contentMode = .scaleAspectFill
        view.insertSubview(authenticReviewBackground, at: 0)

        let contentFilteringDimView = UIView()
        contentFilteringDimView.translatesAutoresizingMaskIntoConstraints = false
        contentFilteringDimView.backgroundColor = UIColor.black.withAlphaComponent(0.42)
        view.addSubview(contentFilteringDimView)

        let communityVettedCard = UIView()
        communityVettedCard.translatesAutoresizingMaskIntoConstraints = false
        communityVettedCard.backgroundColor = .white
        communityVettedCard.layer.cornerRadius = 24
        communityVettedCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        communityVettedCard.layer.masksToBounds = true
        view.addSubview(communityVettedCard)

        let trustedReviewTitle = UILabel()
        trustedReviewTitle.translatesAutoresizingMaskIntoConstraints = false
        trustedReviewTitle.text = BivvyStringVault.eulaTitle
        trustedReviewTitle.font = CommunitySharingAuthTheme.sharingMechanicButtonFont(size: 24)
        trustedReviewTitle.textAlignment = .center

        let communityGuidelineTextView = UITextView()
        communityGuidelineTextView.translatesAutoresizingMaskIntoConstraints = false
        communityGuidelineTextView.isEditable = false
        communityGuidelineTextView.backgroundColor = .clear
        communityGuidelineTextView.textContainerInset = .zero
        communityGuidelineTextView.font = .systemFont(ofSize: 15)
        communityGuidelineTextView.text = """
Welcome to Bivvy.

Effective Date: June 3, 2026

Contact Email: bivvycer@gmail.com

Welcome to Bivvy (the "Application"). This End User License Agreement ("EULA") is a binding legal agreement between you (the "User") and Bivvy. By downloading, installing, or using the Application, you agree to be bound by the terms of this EULA. If you do not agree, do not install or use the Application.

License Grant
Bivvy grants you a revocable, non-exclusive, non-transferable, limited license to download, install, and use the Application on mobile devices owned or controlled by you, strictly in accordance with the terms of this Agreement and the platform rules of the Apple App Store.

User Conduct Restrictions
Bivvy is a community built on trust, sharing, and safe peer-to-peer exchange. To maintain a vibrant environment, you are strictly prohibited from engaging in the following behaviors when posting short videos, recommendations, or listing items for exchange:

Objectionable Content: You shall not upload, post, or transmit any content that is defamatory, obscene, pornographic, vulgar, offensive, harassing, promoting violence, or inciting racial or ethnic hatred.

Abusive & Disruptive Behavior: You shall not bully, intimidate, stalk, or harass other community members in video comments, direct messages, or interactive spaces.

Fraudulent Exchanges: When utilizing the "Exchange Good Finds" feature, you must not list counterfeit goods, stolen properties, hazardous materials, or intentionally misrepresent the condition of items being swapped.

Intellectual Property Infringement: You must not share multimedia content, product video clips, or branding assets that violate the copyrights, trademarks, or proprietary rights of third parties.

Scraping and Automation: You are prohibited from using bots, spiders, scripts, or any automated mechanisms to extract data, save listings, or manipulate the AI-powered product sharing algorithms.

Termination of License and Access
Bivvy reserves the right, in its sole and absolute discretion, to terminate or suspend your license and block your access to the Application at any time, without prior notice or liability, for any reason whatsoever.

Breach of EULA: Any violation of the User Conduct Restrictions outlined above will result in immediate termination of your account and a permanent ban from the Bivvy network.

Content Removal: Bivvy utilizes automated moderation systems and human review panels to actively monitor user behavior. We reserve the right to delete any video, collection, or product recommendation that is deemed harmful or violating community standards without warning.

Effect of Termination: Upon termination, all rights granted to you under this EULA will immediately cease, and you must promptly destroy all copies of the Application in your possession and cease all interactions within the Bivvy ecosystem.

This service is not a random, anonymous, adult, or suggestive chat service.

1. User Conduct
Users may share lawful product finds, useful recommendations, short videos, item collections, and community discovery content only. Harassment, bullying, sexual content, scams, hateful conduct, violence, harmful misinformation, or any illegal content is not allowed.

2. Account Requirements
Users must meet account registration requirements, provide legitimate local identity information when required, and comply with age and local legal eligibility checks.

3. Report and Block Tools
Bivvy provides reporting and blocking mechanisms for unsafe accounts, unlawful content, harassment, and inappropriate product or video sharing behavior.

4. Strict Review and Penalties
Bivvy applies strict content review. Violations may lead to content removal, feature restriction, account suspension, account ban, or other enforcement actions.

By tapping Agree, you accept the Terms of Service and Privacy Policy.
"""

        let contentFilteringCancelButton = UIButton(type: .system)
        contentFilteringCancelButton.translatesAutoresizingMaskIntoConstraints = false
        contentFilteringCancelButton.setTitle(BivvyStringVault.cancel, for: .normal)
        contentFilteringCancelButton.titleLabel?.font = CommunitySharingAuthTheme.sharingMechanicButtonFont(size: 18)
        contentFilteringCancelButton.setTitleColor(.black, for: .normal)
        contentFilteringCancelButton.backgroundColor = CommunitySharingAuthTheme.communityHubSoftPanel
        contentFilteringCancelButton.layer.cornerRadius = 26
        contentFilteringCancelButton.addTarget(self, action: #selector(cancelTrustedReview), for: .touchUpInside)

        let trustedReviewAgreeButton = SharingMechanicGradientButton(title: BivvyStringVault.agree)
        trustedReviewAgreeButton.addTarget(self, action: #selector(acceptTrustedReview), for: .touchUpInside)

        let peerInteractionButtonRow = UIStackView(arrangedSubviews: [contentFilteringCancelButton, trustedReviewAgreeButton])
        peerInteractionButtonRow.translatesAutoresizingMaskIntoConstraints = false
        peerInteractionButtonRow.axis = .horizontal
        peerInteractionButtonRow.spacing = 20
        peerInteractionButtonRow.distribution = .fillEqually

        communityVettedCard.addSubview(trustedReviewTitle)
        communityVettedCard.addSubview(communityGuidelineTextView)
        communityVettedCard.addSubview(peerInteractionButtonRow)

        NSLayoutConstraint.activate([
            authenticReviewBackground.topAnchor.constraint(equalTo: view.topAnchor),
            authenticReviewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authenticReviewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authenticReviewBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentFilteringDimView.topAnchor.constraint(equalTo: view.topAnchor),
            contentFilteringDimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentFilteringDimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentFilteringDimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            communityVettedCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            communityVettedCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            communityVettedCard.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            communityVettedCard.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.64),
            communityVettedCard.heightAnchor.constraint(greaterThanOrEqualToConstant: 460),

            trustedReviewTitle.topAnchor.constraint(equalTo: communityVettedCard.topAnchor, constant: 30),
            trustedReviewTitle.centerXAnchor.constraint(equalTo: communityVettedCard.centerXAnchor),

            communityGuidelineTextView.topAnchor.constraint(equalTo: trustedReviewTitle.bottomAnchor, constant: 24),
            communityGuidelineTextView.leadingAnchor.constraint(equalTo: communityVettedCard.leadingAnchor, constant: 24),
            communityGuidelineTextView.trailingAnchor.constraint(equalTo: communityVettedCard.trailingAnchor, constant: -24),
            communityGuidelineTextView.bottomAnchor.constraint(equalTo: peerInteractionButtonRow.topAnchor, constant: -22),

            peerInteractionButtonRow.leadingAnchor.constraint(equalTo: communityVettedCard.leadingAnchor, constant: 24),
            peerInteractionButtonRow.trailingAnchor.constraint(equalTo: communityVettedCard.trailingAnchor, constant: -24),
            peerInteractionButtonRow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            peerInteractionButtonRow.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func cancelTrustedReview() {
        dismiss(animated: true)
    }

    @objc private func acceptTrustedReview() {
        BivvyComplianceStore.hasAcceptedTrustedReviewEULA = true
        dismiss(animated: true) { [trustedReviewAccepted] in
            trustedReviewAccepted?()
        }
    }
}

typealias BivvyEULAViewController = TrustedReviewEULAViewController
