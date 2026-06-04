import UIKit

final class BivvyAuthEntryViewController: UIViewController {
    private let agreementRow = BivvyAgreementRowView()
    private let emailButton = BivvyGradientButton(title: "Login with Email")
    private let registerButton = BivvyGradientButton(title: "Register an account", style: .black)
    private let errorLabel = UILabel()
    private var hasPresentedInitialEULA = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
        bindAgreementState()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !BivvyComplianceStore.hasAcceptedEULA, !hasPresentedInitialEULA else { return }
        hasPresentedInitialEULA = true
        presentEULA(pushLoginAfterAgree: false)
    }

    private func buildLayout() {
        view.backgroundColor = .black

        let background = UIImageView(image: UIImage(named: "bivvy_auth_entry_background"))
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .scaleAspectFill
        view.addSubview(background)

        let overlay = BivvyGradientView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.colors = [
            UIColor.white.withAlphaComponent(0),
            UIColor(red: 224 / 255, green: 151 / 255, blue: 255 / 255, alpha: 0.9),
            BivvyAuthTheme.pink
        ]
        overlay.startPoint = CGPoint(x: 0.5, y: 0)
        overlay.endPoint = CGPoint(x: 0.5, y: 1)
        view.addSubview(overlay)

        let logo = UIImageView(image: UIImage(named: "bivvy_auth_video_mark"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)

        emailButton.addTarget(self, action: #selector(showEULA), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(openRegister), for: .touchUpInside)
        agreementRow.addTarget(self, action: #selector(agreementChanged), for: .valueChanged)
        agreementRow.onTermsTapped = { [weak self] in
            self?.openH5Route(.termsOfService)
        }
        agreementRow.onPrivacyTapped = { [weak self] in
            self?.openH5Route(.privacyPolicy)
        }

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        errorLabel.textColor = BivvyAuthTheme.hotPink
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center

        let actionStack = UIStackView(arrangedSubviews: [emailButton, registerButton, agreementRow, errorLabel])
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        actionStack.axis = .vertical
        actionStack.spacing = 14
        actionStack.alignment = .fill
        view.addSubview(actionStack)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlay.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.76),

            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 18),
            logo.widthAnchor.constraint(equalToConstant: 120),
            logo.heightAnchor.constraint(equalToConstant: 80),

            actionStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            actionStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            actionStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -14)
        ])
    }

    @objc private func showEULA() {
        guard agreementRow.isChecked else {
            presentEULA(pushLoginAfterAgree: true)
            return
        }

        navigationController?.pushViewController(BivvyLoginViewController(), animated: true)
    }

    private func presentEULA(pushLoginAfterAgree: Bool) {
        let eula = BivvyEULAViewController()
        eula.onAgree = { [weak self] in
            guard let self else { return }
            self.agreementRow.isChecked = true
            self.errorLabel.text = nil
            if pushLoginAfterAgree {
                self.navigationController?.pushViewController(BivvyLoginViewController(), animated: true)
            }
        }
        eula.modalPresentationStyle = .overFullScreen
        present(eula, animated: false)
    }

    @objc private func openRegister() {
        navigationController?.pushViewController(BivvyRegisterViewController(), animated: true)
    }

    @objc private func agreementChanged() {
        BivvyComplianceStore.hasAcceptedEULA = agreementRow.isChecked
        errorLabel.text = nil
    }

    private func bindAgreementState() {
        agreementRow.isChecked = BivvyComplianceStore.hasAcceptedEULA
    }

    private func openH5Route(_ route: BivvyH5Route) {
        guard let url = route.url() else { return }
        navigationController?.pushViewController(BivvyWebViewController(url: url), animated: true)
    }
}
