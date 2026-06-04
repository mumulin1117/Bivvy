import UIKit

final class BivvyRegisterViewController: BivvyKeyboardAvoidingViewController {
    private let emailField = BivvyAuthTextFieldView(title: "Email", placeholder: "Enter email address", iconName: "bivvy_auth_email_icon")
    private let passwordField = BivvyAuthTextFieldView(title: "Password", placeholder: "Enter password", iconName: "bivvy_auth_password_lock", isPassword: true)
    private let nextButton = BivvyGradientButton(title: "Next")
    private let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    private func buildLayout() {
        view.backgroundColor = .white

        let background = BivvyGradientView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.isUserInteractionEnabled = false
        background.colors = [
            UIColor(red: 255 / 255, green: 235 / 255, blue: 244 / 255, alpha: 1),
            .white,
            .white
        ]
        background.startPoint = CGPoint(x: 0.5, y: 0)
        background.endPoint = CGPoint(x: 0.5, y: 1)
        view.insertSubview(background, belowSubview: scrollView)

        let back = UIButton(type: .custom)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setImage(UIImage(named: "bivvy_auth_back_icon"), for: .normal)
        back.addTarget(self, action: #selector(goBack), for: .touchUpInside)

        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "CREATE AN ACCOUNT"
        title.font = BivvyAuthTheme.displayFont(size: 31)
        title.adjustsFontSizeToFitWidth = true
        title.textAlignment = .center

        let avatarContainer = UIView()
        avatarContainer.translatesAutoresizingMaskIntoConstraints = false
        let avatar = UIImageView(image: UIImage(named: "bivvy_auth_profile_avatar"))
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = 50
        avatar.layer.masksToBounds = true
        let camera = UIImageView(image: UIImage(named: "bivvy_auth_camera_badge"))
        camera.translatesAutoresizingMaskIntoConstraints = false
        camera.contentMode = .scaleAspectFit
        avatarContainer.addSubview(avatar)
        avatarContainer.addSubview(camera)

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        errorLabel.textColor = BivvyAuthTheme.hotPink
        errorLabel.numberOfLines = 0

        nextButton.addTarget(self, action: #selector(continueToProfileSetup), for: .touchUpInside)

        [back, title, avatarContainer, emailField, passwordField, nextButton, errorLabel].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            back.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            back.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            back.widthAnchor.constraint(equalToConstant: 44),
            back.heightAnchor.constraint(equalToConstant: 44),

            title.topAnchor.constraint(equalTo: back.bottomAnchor, constant: 72),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            avatarContainer.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 40),
            avatarContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarContainer.widthAnchor.constraint(equalToConstant: 112),
            avatarContainer.heightAnchor.constraint(equalToConstant: 112),

            avatar.centerXAnchor.constraint(equalTo: avatarContainer.centerXAnchor),
            avatar.centerYAnchor.constraint(equalTo: avatarContainer.centerYAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalToConstant: 100),

            camera.trailingAnchor.constraint(equalTo: avatarContainer.trailingAnchor, constant: -4),
            camera.bottomAnchor.constraint(equalTo: avatarContainer.bottomAnchor, constant: -4),
            camera.widthAnchor.constraint(equalToConstant: 34),
            camera.heightAnchor.constraint(equalToConstant: 34),

            emailField.topAnchor.constraint(equalTo: avatarContainer.bottomAnchor, constant: 58),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 44),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),

            nextButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 96),
            nextButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            nextButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            errorLabel.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 14),
            errorLabel.leadingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: 12),
            errorLabel.trailingAnchor.constraint(equalTo: nextButton.trailingAnchor, constant: -12),
            errorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -32)
        ])
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func continueToProfileSetup() {
        guard emailField.text.contains("@"), emailField.text.contains(".") else {
            errorLabel.text = "Please enter a valid email address."
            return
        }
        guard passwordField.text.count >= 6 else {
            errorLabel.text = "Password must be at least 6 characters."
            return
        }
        errorLabel.text = nil
        let profile = BivvyProfileSetupViewController(email: emailField.text, password: passwordField.text)
        navigationController?.pushViewController(profile, animated: true)
    }
}
