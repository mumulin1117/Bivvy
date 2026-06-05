
import UIKit

final class ProductTaggingAuthTextFieldView: UIView {
    let productTaggingTextField = UITextField()
    private let productTaggingTitleLabel = UILabel()
    private let productHighlightIconView = UIImageView()
    private let contentFilteringPasswordToggle = UIButton(type: .system)
    private let productHighlightIconContainer = UIView()
    private let contentFilteringIsPassword: Bool

    var text: String {
        productTaggingTextField.text ?? BivvyStringVault.tokenEmpty
    }

    init(productTaggingTitle: String, conversationStarterPlaceholder: String, productHighlightIconName: String? = nil, contentFilteringIsPassword: Bool = false) {
        self.contentFilteringIsPassword = contentFilteringIsPassword
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.5
        layer.cornerRadius = 28
        backgroundColor = .clear

        productTaggingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        productTaggingTitleLabel.text = productTaggingTitle
        productTaggingTitleLabel.font = CommunitySharingAuthTheme.productShowcaseTitleFont(size: 16)
        productTaggingTitleLabel.backgroundColor = .white
        productTaggingTitleLabel.textColor = .black
        productTaggingTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        addSubview(productTaggingTitleLabel)

        productTaggingTextField.translatesAutoresizingMaskIntoConstraints = false
        productTaggingTextField.placeholder = conversationStarterPlaceholder
        productTaggingTextField.font = .systemFont(ofSize: 16)
        productTaggingTextField.textColor = .black
        productTaggingTextField.tintColor = CommunitySharingAuthTheme.favoriteFindPink
        productTaggingTextField.isSecureTextEntry = contentFilteringIsPassword
        productTaggingTextField.autocapitalizationType = .none
        productTaggingTextField.autocorrectionType = .no
        productTaggingTextField.keyboardType = productTaggingTitle.lowercased().contains(BivvyStringVault.emailNeedle) ? .emailAddress : .default
        addSubview(productTaggingTextField)

        productHighlightIconContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(productHighlightIconContainer)

        productHighlightIconView.translatesAutoresizingMaskIntoConstraints = false
        productHighlightIconView.contentMode = .scaleAspectFit
        productHighlightIconView.tintColor = CommunitySharingAuthTheme.favoriteFindPink
        productHighlightIconView.image = productHighlightIconName.flatMap { UIImage(named: $0) }
        productHighlightIconContainer.addSubview(productHighlightIconView)

        contentFilteringPasswordToggle.translatesAutoresizingMaskIntoConstraints = false
        contentFilteringPasswordToggle.tintColor = CommunitySharingAuthTheme.favoriteFindPink
        contentFilteringPasswordToggle.setImage(UIImage(systemName: BivvyStringVault.eyeSlash), for: .normal)
        contentFilteringPasswordToggle.addTarget(self, action: #selector(toggleContentFilteringPasswordVisibility), for: .touchUpInside)
        contentFilteringPasswordToggle.isHidden = !contentFilteringIsPassword
        productHighlightIconContainer.addSubview(contentFilteringPasswordToggle)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            productTaggingTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 72),
            productTaggingTitleLabel.centerYAnchor.constraint(equalTo: topAnchor),
            productTaggingTitleLabel.heightAnchor.constraint(equalToConstant: 24),

            productTaggingTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            productTaggingTextField.trailingAnchor.constraint(equalTo: productHighlightIconContainer.leadingAnchor, constant: -8),
            productTaggingTextField.centerYAnchor.constraint(equalTo: centerYAnchor),

            productHighlightIconContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            productHighlightIconContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            productHighlightIconContainer.widthAnchor.constraint(equalToConstant: contentFilteringIsPassword ? 62 : 26),
            productHighlightIconContainer.heightAnchor.constraint(equalToConstant: 32),

            productHighlightIconView.leadingAnchor.constraint(equalTo: productHighlightIconContainer.leadingAnchor),
            productHighlightIconView.centerYAnchor.constraint(equalTo: productHighlightIconContainer.centerYAnchor),
            productHighlightIconView.widthAnchor.constraint(equalToConstant: 24),
            productHighlightIconView.heightAnchor.constraint(equalToConstant: 24),

            contentFilteringPasswordToggle.trailingAnchor.constraint(equalTo: productHighlightIconContainer.trailingAnchor),
            contentFilteringPasswordToggle.centerYAnchor.constraint(equalTo: productHighlightIconContainer.centerYAnchor),
            contentFilteringPasswordToggle.widthAnchor.constraint(equalToConstant: 30),
            contentFilteringPasswordToggle.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func toggleContentFilteringPasswordVisibility() {
        productTaggingTextField.isSecureTextEntry.toggle()
        let contentFilteringIconName = productTaggingTextField.isSecureTextEntry ? BivvyStringVault.eyeSlash : BivvyStringVault.eye
        contentFilteringPasswordToggle.setImage(UIImage(systemName: contentFilteringIconName), for: .normal)
    }
}

typealias BivvyAuthTextFieldView = ProductTaggingAuthTextFieldView
