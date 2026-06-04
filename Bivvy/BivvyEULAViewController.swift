import UIKit

final class BivvyEULAViewController: UIViewController {
    var onAgree: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    private func buildLayout() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.48)

        let background = UIImageView(image: UIImage(named: "bivvy_auth_login_hero"))
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .scaleAspectFill
        view.insertSubview(background, at: 0)

        let dim = UIView()
        dim.translatesAutoresizingMaskIntoConstraints = false
        dim.backgroundColor = UIColor.black.withAlphaComponent(0.42)
        view.addSubview(dim)

        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .white
        card.layer.cornerRadius = 24
        card.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        card.layer.masksToBounds = true
        view.addSubview(card)

        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Bivvy  EULA"
        title.font = BivvyAuthTheme.buttonFont(size: 24)
        title.textAlignment = .center

        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.font = .systemFont(ofSize: 15)
        textView.text = """
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

        let cancelButton = UIButton(type: .system)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = BivvyAuthTheme.buttonFont(size: 18)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.backgroundColor = BivvyAuthTheme.softPanel
        cancelButton.layer.cornerRadius = 26
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)

        let agreeButton = BivvyGradientButton(title: "Agree")
        agreeButton.addTarget(self, action: #selector(agree), for: .touchUpInside)

        let buttonRow = UIStackView(arrangedSubviews: [cancelButton, agreeButton])
        buttonRow.translatesAutoresizingMaskIntoConstraints = false
        buttonRow.axis = .horizontal
        buttonRow.spacing = 20
        buttonRow.distribution = .fillEqually

        card.addSubview(title)
        card.addSubview(textView)
        card.addSubview(buttonRow)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            dim.topAnchor.constraint(equalTo: view.topAnchor),
            dim.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dim.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dim.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            card.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            card.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.64),
            card.heightAnchor.constraint(greaterThanOrEqualToConstant: 460),

            title.topAnchor.constraint(equalTo: card.topAnchor, constant: 30),
            title.centerXAnchor.constraint(equalTo: card.centerXAnchor),

            textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 24),
            textView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 24),
            textView.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -24),
            textView.bottomAnchor.constraint(equalTo: buttonRow.topAnchor, constant: -22),

            buttonRow.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 24),
            buttonRow.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -24),
            buttonRow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            buttonRow.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func cancel() {
        dismiss(animated: true)
    }

    @objc private func agree() {
        BivvyComplianceStore.hasAcceptedEULA = true
        dismiss(animated: true) { [onAgree] in
            onAgree?()
        }
    }
}
