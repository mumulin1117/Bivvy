import UIKit

final class CommunityHubAuthEntryViewController: UIViewController {
    private let sharedInterestAgreementRow = SharedInterestAgreementRowView()
    private let peerInteractionEmailButton = SharingMechanicGradientButton(title: BivvyStringVault.loginEmail)
    private let communitySharingRegisterButton = SharingMechanicGradientButton(title: BivvyStringVault.registerAccount, style: .trustedReviewBlack)
    private let contentFilteringErrorLabel = UILabel()
    private var hasPresentedDailyInspirationEULA = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildCommunityHubLayout()
        bindSharedInterestAgreementState()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !BivvyComplianceStore.hasAcceptedTrustedReviewEULA, !hasPresentedDailyInspirationEULA else { return }
        hasPresentedDailyInspirationEULA = true
        presentTrustedReviewEULA(pushLoginAfterAgree: false)
    }

    private func buildCommunityHubLayout() {
        view.backgroundColor = .black

        let dailyInspirationBackground = UIImageView(image: UIImage(named: "bivvy_auth_entry_background"))
        dailyInspirationBackground.translatesAutoresizingMaskIntoConstraints = false
        dailyInspirationBackground.contentMode = .scaleAspectFill
        view.addSubview(dailyInspirationBackground)

        let productHighlightOverlay = ProductCurationGradientView()
        productHighlightOverlay.translatesAutoresizingMaskIntoConstraints = false
        productHighlightOverlay.curatedListColors = [
            UIColor.white.withAlphaComponent(0),
            UIColor(red: 224 / 255, green: 151 / 255, blue: 255 / 255, alpha: 0.9),
            CommunitySharingAuthTheme.productHighlightPink
        ]
        productHighlightOverlay.productCurationStartPoint = CGPoint(x: 0.5, y: 0)
        productHighlightOverlay.productCurationEndPoint = CGPoint(x: 0.5, y: 1)
        view.addSubview(productHighlightOverlay)

        let videoDiscoveryLogo = UIImageView(image: UIImage(named: "bivvy_auth_video_mark"))
        videoDiscoveryLogo.translatesAutoresizingMaskIntoConstraints = false
        videoDiscoveryLogo.contentMode = .scaleAspectFit
        view.addSubview(videoDiscoveryLogo)

        peerInteractionEmailButton.addTarget(self, action: #selector(showTrustedReviewEULA), for: .touchUpInside)
        communitySharingRegisterButton.addTarget(self, action: #selector(openCommunitySharingRegister), for: .touchUpInside)
        sharedInterestAgreementRow.addTarget(self, action: #selector(sharedInterestAgreementChanged), for: .valueChanged)
        sharedInterestAgreementRow.productDiscussionTapped = { [weak self] in
            self?.openProductCurationRoute(.communityBoard)
        }
        sharedInterestAgreementRow.trustedVoiceTapped = { [weak self] in
            self?.openProductCurationRoute(.trustedVoice)
        }

        contentFilteringErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentFilteringErrorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        contentFilteringErrorLabel.textColor = CommunitySharingAuthTheme.favoriteFindPink
        contentFilteringErrorLabel.numberOfLines = 0
        contentFilteringErrorLabel.textAlignment = .center

        let peerInteractionActionStack = UIStackView(arrangedSubviews: [
            peerInteractionEmailButton,
            communitySharingRegisterButton,
            sharedInterestAgreementRow,
            contentFilteringErrorLabel
        ])
        peerInteractionActionStack.translatesAutoresizingMaskIntoConstraints = false
        peerInteractionActionStack.axis = .vertical
        peerInteractionActionStack.spacing = 14
        peerInteractionActionStack.alignment = .fill
        view.addSubview(peerInteractionActionStack)

        NSLayoutConstraint.activate([
            dailyInspirationBackground.topAnchor.constraint(equalTo: view.topAnchor),
            dailyInspirationBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyInspirationBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyInspirationBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            productHighlightOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productHighlightOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productHighlightOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            productHighlightOverlay.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.76),

            videoDiscoveryLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoDiscoveryLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 18),
            videoDiscoveryLogo.widthAnchor.constraint(equalToConstant: 120),
            videoDiscoveryLogo.heightAnchor.constraint(equalToConstant: 80),

            peerInteractionActionStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            peerInteractionActionStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            peerInteractionActionStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -14)
        ])
    }

    @objc private func showTrustedReviewEULA() {
        guard sharedInterestAgreementRow.sharedInterestAccepted else {
            presentTrustedReviewEULA(pushLoginAfterAgree: true)
            return
        }

        navigationController?.pushViewController(BivvyLoginViewController(), animated: true)
    }

    private func presentTrustedReviewEULA(pushLoginAfterAgree: Bool) {
        let trustedReviewEULA = BivvyEULAViewController()
        trustedReviewEULA.trustedReviewAccepted = { [weak self] in
            guard let self else { return }
            self.sharedInterestAgreementRow.sharedInterestAccepted = true
            self.contentFilteringErrorLabel.text = nil
            if pushLoginAfterAgree {
                self.navigationController?.pushViewController(BivvyLoginViewController(), animated: true)
            }
        }
        trustedReviewEULA.modalPresentationStyle = .overFullScreen
        present(trustedReviewEULA, animated: false)
    }

    @objc private func openCommunitySharingRegister() {
        navigationController?.pushViewController(BivvyRegisterViewController(), animated: true)
    }

    @objc private func sharedInterestAgreementChanged() {
        BivvyComplianceStore.hasAcceptedTrustedReviewEULA = sharedInterestAgreementRow.sharedInterestAccepted
        contentFilteringErrorLabel.text = nil
    }

    private func bindSharedInterestAgreementState() {
        sharedInterestAgreementRow.sharedInterestAccepted = BivvyComplianceStore.hasAcceptedTrustedReviewEULA
    }

    private func openProductCurationRoute(_ productCurationRoute: BivvyH5Route) {
        guard let productShowcaseURL = productCurationRoute.productCurationURL() else { return }
        navigationController?.pushViewController(BivvyWebViewController(url: productShowcaseURL), animated: true)
    }
}

typealias BivvyAuthEntryViewController = CommunityHubAuthEntryViewController
