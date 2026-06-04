import UIKit

final class BivvyAuthTextFieldView: UIView {
    let textField = UITextField()
    private let titleLabel = UILabel()
    private let iconView = UIImageView()
    private let passwordToggle = UIButton(type: .system)
    private let iconContainer = UIView()
    private let isPassword: Bool

    var text: String {
        textField.text ?? ""
    }

    init(title: String, placeholder: String, iconName: String? = nil, isPassword: Bool = false) {
        self.isPassword = isPassword
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.5
        layer.cornerRadius = 28
        backgroundColor = .clear

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = BivvyAuthTheme.titleFont(size: 16)
        titleLabel.backgroundColor = .white
        titleLabel.textColor = .black
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        addSubview(titleLabel)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = BivvyAuthTheme.hotPink
        textField.isSecureTextEntry = isPassword
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = title.lowercased().contains("email") ? .emailAddress : .default
        addSubview(textField)

        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconContainer)

        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = BivvyAuthTheme.hotPink
        iconView.image = iconName.flatMap { UIImage(named: $0) }
        iconContainer.addSubview(iconView)

        passwordToggle.translatesAutoresizingMaskIntoConstraints = false
        passwordToggle.tintColor = BivvyAuthTheme.hotPink
        passwordToggle.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggle.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordToggle.isHidden = !isPassword
        iconContainer.addSubview(passwordToggle)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 72),
            titleLabel.centerYAnchor.constraint(equalTo: topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),

            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            textField.trailingAnchor.constraint(equalTo: iconContainer.leadingAnchor, constant: -8),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),

            iconContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            iconContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: isPassword ? 62 : 26),
            iconContainer.heightAnchor.constraint(equalToConstant: 32),

            iconView.leadingAnchor.constraint(equalTo: iconContainer.leadingAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),

            passwordToggle.trailingAnchor.constraint(equalTo: iconContainer.trailingAnchor),
            passwordToggle.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            passwordToggle.widthAnchor.constraint(equalToConstant: 30),
            passwordToggle.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        let iconName = textField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggle.setImage(UIImage(systemName: iconName), for: .normal)
    }
}
