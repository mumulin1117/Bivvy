import UIKit

final class ProductReviewLoginViewController: ContentFilteringKeyboardAvoidingViewController {
    private let peerInteractionEmailField = ProductTaggingAuthTextFieldView(productTaggingTitle: BivvyStringVault.email, conversationStarterPlaceholder: BivvyStringVault.enterEmail, productHighlightIconName: "bivvy_auth_email_icon")
    private let contentFilteringPasswordField = ProductTaggingAuthTextFieldView(productTaggingTitle: BivvyStringVault.password, conversationStarterPlaceholder: BivvyStringVault.enterPassword, productHighlightIconName: "bivvy_auth_password_lock", contentFilteringIsPassword: true)
    private let peerInteractionLoginButton = SharingMechanicGradientButton(title: BivvyStringVault.login)
   
    private let contentFilteringErrorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildProductReviewLoginLayout()
    }

    private func buildProductReviewLoginLayout() {
        view.backgroundColor = .white

        let authenticReviewHero = UIImageView(image: UIImage(named: "bivvy_auth_login_hero"))
        authenticReviewHero.translatesAutoresizingMaskIntoConstraints = false
        authenticReviewHero.contentMode = .scaleAspectFill
        authenticReviewHero.layer.cornerRadius = 100
        authenticReviewHero.layer.maskedCorners = [.layerMinXMaxYCorner]
        authenticReviewHero.layer.masksToBounds = true

        let productReviewBackButton = UIButton(type: .custom)
        productReviewBackButton.translatesAutoresizingMaskIntoConstraints = false
        productReviewBackButton.setImage(UIImage(named: "bivvy_auth_back_icon"), for: .normal)
        productReviewBackButton.addTarget(self, action: #selector(closeProductReviewLogin), for: .touchUpInside)

        let dailyInspirationTitle = UILabel()
        dailyInspirationTitle.translatesAutoresizingMaskIntoConstraints = false
        dailyInspirationTitle.text = BivvyStringVault.welcomeLogin
        dailyInspirationTitle.textColor = .white
        dailyInspirationTitle.font = CommunitySharingAuthTheme.dailyInspirationDisplayFont(size: 29)
        dailyInspirationTitle.adjustsFontSizeToFitWidth = true

        contentFilteringErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentFilteringErrorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        contentFilteringErrorLabel.textColor = CommunitySharingAuthTheme.favoriteFindPink
        contentFilteringErrorLabel.numberOfLines = 0

        peerInteractionLoginButton.addTarget(self, action: #selector(startPeerInteractionLogin), for: .touchUpInside)

        [
            authenticReviewHero,
            productReviewBackButton,
            dailyInspirationTitle,
            peerInteractionEmailField,
            contentFilteringPasswordField,
            peerInteractionLoginButton,
            contentFilteringErrorLabel
        ].forEach(communitySharingContentView.addSubview)

        NSLayoutConstraint.activate([
            authenticReviewHero.topAnchor.constraint(equalTo: communitySharingContentView.topAnchor),
            authenticReviewHero.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor),
            authenticReviewHero.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor),
            authenticReviewHero.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.46),

            productReviewBackButton.topAnchor.constraint(equalTo: communitySharingContentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            productReviewBackButton.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 12),
            productReviewBackButton.widthAnchor.constraint(equalToConstant: 44),
            productReviewBackButton.heightAnchor.constraint(equalToConstant: 44),

            dailyInspirationTitle.centerXAnchor.constraint(equalTo: authenticReviewHero.centerXAnchor),
            dailyInspirationTitle.bottomAnchor.constraint(equalTo: authenticReviewHero.bottomAnchor, constant: -38),
            dailyInspirationTitle.leadingAnchor.constraint(greaterThanOrEqualTo: authenticReviewHero.leadingAnchor, constant: 28),

            peerInteractionEmailField.topAnchor.constraint(equalTo: authenticReviewHero.bottomAnchor, constant: 44),
            peerInteractionEmailField.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 20),
            peerInteractionEmailField.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -20),

            contentFilteringPasswordField.topAnchor.constraint(equalTo: peerInteractionEmailField.bottomAnchor, constant: 44),
            contentFilteringPasswordField.leadingAnchor.constraint(equalTo: peerInteractionEmailField.leadingAnchor),
            contentFilteringPasswordField.trailingAnchor.constraint(equalTo: peerInteractionEmailField.trailingAnchor),

            peerInteractionLoginButton.topAnchor.constraint(equalTo: contentFilteringPasswordField.bottomAnchor, constant: 50),
            peerInteractionLoginButton.leadingAnchor.constraint(equalTo: communitySharingContentView.leadingAnchor, constant: 12),
            peerInteractionLoginButton.trailingAnchor.constraint(equalTo: communitySharingContentView.trailingAnchor, constant: -12),

        
            contentFilteringErrorLabel.bottomAnchor.constraint(equalTo: peerInteractionLoginButton.topAnchor, constant: 12),
            contentFilteringErrorLabel.leadingAnchor.constraint(equalTo: peerInteractionLoginButton.leadingAnchor),
            contentFilteringErrorLabel.trailingAnchor.constraint(equalTo: peerInteractionLoginButton.trailingAnchor),
            
        ])
    }

    @objc private func closeProductReviewLogin() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func startPeerInteractionLogin() {
     
        guard !peerInteractionEmailField.text.isEmpty, !contentFilteringPasswordField.text.isEmpty else {
            contentFilteringErrorLabel.text = BivvyStringVault.emailReq
            return
        }

        peerInteractionLoginButton.isSharingMechanicLoading = true
        contentFilteringErrorLabel.text = nil
        CommunitySharingAuthStore.communityHub.peerInteractionLogin(email: peerInteractionEmailField.text, password: contentFilteringPasswordField.text) { [weak self] productReviewResult in
            guard let self else { return }
            self.peerInteractionLoginButton.isSharingMechanicLoading = false
            switch productReviewResult {
            case .success:
                (self.view.window?.windowScene?.delegate as? BivvySceneDelegate)?.showMainInterface()
            case .failure(let contentFilteringError):
                self.contentFilteringErrorLabel.text = contentFilteringError.localizedDescription
            }
        }
    }
}

typealias BivvyLoginViewController = ProductReviewLoginViewController
