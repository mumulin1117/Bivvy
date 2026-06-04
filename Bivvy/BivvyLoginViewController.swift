import UIKit

final class BivvyLoginViewController: BivvyKeyboardAvoidingViewController {
    private let emailField = BivvyAuthTextFieldView(title: "Email", placeholder: "Enter email address", iconName: "bivvy_auth_email_icon")
    private let passwordField = BivvyAuthTextFieldView(title: "Password", placeholder: "Enter password", iconName: "bivvy_auth_password_lock", isPassword: true)
    private let loginButton = BivvyGradientButton(title: "Login")
   
    private let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    private func buildLayout() {
        view.backgroundColor = .white

        let hero = UIImageView(image: UIImage(named: "bivvy_auth_login_hero"))
        hero.translatesAutoresizingMaskIntoConstraints = false
        hero.contentMode = .scaleAspectFill
        hero.layer.cornerRadius = 100
        hero.layer.maskedCorners = [.layerMinXMaxYCorner]
        hero.layer.masksToBounds = true

        let back = UIButton(type: .custom)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setImage(UIImage(named: "bivvy_auth_back_icon"), for: .normal)
        back.addTarget(self, action: #selector(goBack), for: .touchUpInside)

        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "WELCOME  LOGIN"
        title.textColor = .white
        title.font = BivvyAuthTheme.displayFont(size: 29)
        title.adjustsFontSizeToFitWidth = true

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        errorLabel.textColor = BivvyAuthTheme.hotPink
        errorLabel.numberOfLines = 0

        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)

        [hero, back, title, emailField, passwordField, loginButton, errorLabel].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            hero.topAnchor.constraint(equalTo: contentView.topAnchor),
            hero.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hero.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hero.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.46),

            back.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            back.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            back.widthAnchor.constraint(equalToConstant: 44),
            back.heightAnchor.constraint(equalToConstant: 44),

            title.centerXAnchor.constraint(equalTo: hero.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: hero.bottomAnchor, constant: -38),
            title.leadingAnchor.constraint(greaterThanOrEqualTo: hero.leadingAnchor, constant: 28),

            emailField.topAnchor.constraint(equalTo: hero.bottomAnchor, constant: 44),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 44),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

        
            errorLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: 12),
            errorLabel.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            
        ])
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func login() {
     
        guard !emailField.text.isEmpty, !passwordField.text.isEmpty else {
            errorLabel.text = "Email and password are required."
            return
        }

        loginButton.isLoading = true
        errorLabel.text = nil
        BivvyMockAuthStore.shared.login(email: emailField.text, password: passwordField.text) { [weak self] result in
            guard let self else { return }
            self.loginButton.isLoading = false
            switch result {
            case .success:
                (self.view.window?.windowScene?.delegate as? BivvySceneDelegate)?.showMainInterface()
            case .failure(let error):
                self.errorLabel.text = error.localizedDescription
            }
        }
    }
}
