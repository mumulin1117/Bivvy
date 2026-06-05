import UIKit

final class CommunitySharingRegisterViewController: ContentFilteringKeyboardAvoidingViewController {
    private let peerInteractionEmailField = ProductTaggingAuthTextFieldView(productTaggingTitle: "Email", conversationStarterPlaceholder: "Enter email address", productHighlightIconName: "bivvy_auth_email_icon")
    private let contentFilteringPasswordField = ProductTaggingAuthTextFieldView(productTaggingTitle: "Password", conversationStarterPlaceholder: "Enter password", productHighlightIconName: "bivvy_auth_password_lock", contentFilteringIsPassword: true)
    private let communitySharingNextButton = SharingMechanicGradientButton(title: BivvyStringVault.next)
    private let contentFilteringErrorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildCommunitySharingRegisterLayout()
    }

    private func buildCommunitySharingRegisterLayout() {
        view.backgroundColor = .white

        let productInspirationBackground = ProductCurationGradientView()
        productInspirationBackground.translatesAutoresizingMaskIntoConstraints = false
        productInspirationBackground.isUserInteractionEnabled = false
        productInspirationBackground.curatedListColors = [
            UIColor(red: 255 / 255, green: 235 / 255, blue: 244 / 255, alpha: 1),
            .white,
            .white
        ]
        productInspirationBackground.productCurationStartPoint = CGPoint(x: 0.5, y: 0)
        productInspirationBackground.productCurationEndPoint = CGPoint(x: 0.5, y: 1)
        view.insertSubview(productInspirationBackground, belowSubview: contentFilteringScrollView)

        let communitySharingBackButton = UIButton(type: .custom)
        communitySharingBackButton.translatesAutoresizingMaskIntoConstraints = false
        communitySharingBackButton.setImage(UIImage(named: "bivvy_auth_back_icon"), for: .normal)
        communitySharingBackButton.addTarget(self, action: #selector(closeCommunitySharingRegister), for: .touchUpInside)

        let communitySharingTitle = UILabel()
        communitySharingTitle.translatesAutoresizingMaskIntoConstraints = false
        communitySharingTitle.text = BivvyStringVault.createAccount
        communitySharingTitle.font = CommunitySharingAuthTheme.dailyInspirationDisplayFont(size: 31)
        communitySharingTitle.adjustsFontSizeToFitWidth = true
        communitySharingTitle.textAlignment = .center

        let contentCreatorAvatarContainer = UIView()
        contentCreatorAvatarContainer.translatesAutoresizingMaskIntoConstraints = false
        let contentCreatorAvatar = UIImageView(image: UIImage(named: "bivvy_auth_profile_avatar"))
        contentCreatorAvatar.translatesAutoresizingMaskIntoConstraints = false
        contentCreatorAvatar.contentMode = .scaleAspectFill
        contentCreatorAvatar.layer.cornerRadius = 50
        contentCreatorAvatar.layer.masksToBounds = true
        let productDemoCameraBadge = UIImageView(image: UIImage(named: "bivvy_auth_camera_badge"))
        productDemoCameraBadge.translatesAutoresizingMaskIntoConstraints = false
        productDemoCameraBadge.contentMode = .scaleAspectFit
        contentCreatorAvatarContainer.addSubview(contentCreatorAvatar)
        contentCreatorAvatarContainer.addSubview(productDemoCameraBadge)

        contentFilteringErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentFilteringErrorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        contentFilteringErrorLabel.textColor = CommunitySharingAuthTheme.favoriteFindPink
        contentFilteringErrorLabel.numberOfLines = 0

        communitySharingNextButton.addTarget(self, action: #selector(continueToProductCurationProfile), for: .touchUpInside)

        [
            communitySharingBackButton,
            communitySharingTitle,
            contentCreatorAvatarContainer,
            peerInteractionEmailField,
            contentFilteringPasswordField,
            communitySharingNextButton,
            contentFilteringErrorLabel
        ].forEach(communitySharingContentView.addSubview)

        NSLayoutConstraint.activate([
            productInspirationBackground.topAnchor.constraint(equalTo: view.topAnchor),
            productInspirationBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productInspirationBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productInspirationBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            communitySharingBackButton.topAnchor.constraint(equalTo: communitySharingContentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            communitySharingBackButton.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 12),
            communitySharingBackButton.widthAnchor.constraint(equalToConstant: 44),
            communitySharingBackButton.heightAnchor.constraint(equalToConstant: 44),

            communitySharingTitle.topAnchor.constraint(equalTo: communitySharingBackButton.bottomAnchor, constant: 72),
            communitySharingTitle.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 24),
            communitySharingTitle.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -24),

            contentCreatorAvatarContainer.topAnchor.constraint(equalTo: communitySharingTitle.bottomAnchor, constant: 40),
            contentCreatorAvatarContainer.centerXAnchor.constraint(equalTo: communitySharingContentView.centerXAnchor),
            contentCreatorAvatarContainer.widthAnchor.constraint(equalToConstant: 112),
            contentCreatorAvatarContainer.heightAnchor.constraint(equalToConstant: 112),

            contentCreatorAvatar.centerXAnchor.constraint(equalTo: contentCreatorAvatarContainer.centerXAnchor),
            contentCreatorAvatar.centerYAnchor.constraint(equalTo: contentCreatorAvatarContainer.centerYAnchor),
            contentCreatorAvatar.widthAnchor.constraint(equalToConstant: 100),
            contentCreatorAvatar.heightAnchor.constraint(equalToConstant: 100),

            productDemoCameraBadge.trailingAnchor.constraint(equalTo: contentCreatorAvatarContainer.trailingAnchor, constant: -4),
            productDemoCameraBadge.bottomAnchor.constraint(equalTo: contentCreatorAvatarContainer.bottomAnchor, constant: -4),
            productDemoCameraBadge.widthAnchor.constraint(equalToConstant: 34),
            productDemoCameraBadge.heightAnchor.constraint(equalToConstant: 34),

            peerInteractionEmailField.topAnchor.constraint(equalTo: contentCreatorAvatarContainer.bottomAnchor, constant: 58),
            peerInteractionEmailField.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 20),
            peerInteractionEmailField.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -20),

            contentFilteringPasswordField.topAnchor.constraint(equalTo: peerInteractionEmailField.bottomAnchor, constant: 44),
            contentFilteringPasswordField.leadingAnchor.constraint(equalTo: peerInteractionEmailField.leadingAnchor),
            contentFilteringPasswordField.trailingAnchor.constraint(equalTo: peerInteractionEmailField.trailingAnchor),

            communitySharingNextButton.topAnchor.constraint(equalTo: contentFilteringPasswordField.bottomAnchor, constant: 96),
            communitySharingNextButton.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 12),
            communitySharingNextButton.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -12),

            contentFilteringErrorLabel.topAnchor.constraint(equalTo: communitySharingNextButton.bottomAnchor, constant: 14),
            contentFilteringErrorLabel.leadingAnchor.constraint(equalTo: communitySharingNextButton.leadingAnchor, constant: 12),
            contentFilteringErrorLabel.trailingAnchor.constraint(equalTo: communitySharingNextButton.trailingAnchor, constant: -12),
            contentFilteringErrorLabel.bottomAnchor.constraint(lessThanOrEqualTo: communitySharingContentView.bottomAnchor, constant: -32)
        ])
    }

    @objc private func closeCommunitySharingRegister() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func continueToProductCurationProfile() {
        guard peerInteractionEmailField.text.contains("@"), peerInteractionEmailField.text.contains(".") else {
            contentFilteringErrorLabel.text = BivvyStringVault.validEmail
            return
        }
        guard contentFilteringPasswordField.text.count >= 6 else {
            contentFilteringErrorLabel.text = BivvyStringVault.passLen
            return
        }
        contentFilteringErrorLabel.text = nil
        let productCurationProfile = ProductCurationProfileSetupViewController(email: peerInteractionEmailField.text, password: contentFilteringPasswordField.text)
        navigationController?.pushViewController(productCurationProfile, animated: true)
    }
}

typealias BivvyRegisterViewController = CommunitySharingRegisterViewController
