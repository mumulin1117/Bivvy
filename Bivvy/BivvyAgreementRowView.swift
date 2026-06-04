import UIKit

final class BivvyAgreementRowView: UIControl {
    private let checkImageView = UIImageView()
    private let label = UILabel()
    private let termsButton = UIButton(type: .system)
    private let privacyButton = UIButton(type: .system)

    var onTermsTapped: (() -> Void)?
    var onPrivacyTapped: (() -> Void)?

    var isChecked = false {
        didSet {
            checkImageView.image = UIImage(named: isChecked ? "bivvy_auth_agreement_active" : "bivvy_auth_agreement_idle")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(toggle), for: .touchUpInside)

        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkImageView.contentMode = .scaleAspectFit
        addSubview(checkImageView)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "I have read and agree to"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        addSubview(label)

        termsButton.translatesAutoresizingMaskIntoConstraints = false
        termsButton.setTitle("Terms of Service", for: .normal)
        termsButton.titleLabel?.font = .italicSystemFont(ofSize: 13)
        termsButton.setTitleColor(.black, for: .normal)
        termsButton.addTarget(self, action: #selector(openTerms), for: .touchUpInside)
        addSubview(termsButton)

        privacyButton.translatesAutoresizingMaskIntoConstraints = false
        privacyButton.setTitle("Privacy Policy", for: .normal)
        privacyButton.titleLabel?.font = .italicSystemFont(ofSize: 13)
        privacyButton.setTitleColor(.black, for: .normal)
        privacyButton.addTarget(self, action: #selector(openPrivacy), for: .touchUpInside)
        addSubview(privacyButton)

        NSLayoutConstraint.activate([
            checkImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkImageView.topAnchor.constraint(equalTo: topAnchor),
            checkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkImageView.heightAnchor.constraint(equalToConstant: 24),

            label.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: topAnchor, constant: -1),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),

            termsButton.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            termsButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2),
            termsButton.heightAnchor.constraint(equalToConstant: 24),

            privacyButton.leadingAnchor.constraint(equalTo: termsButton.trailingAnchor, constant: 10),
            privacyButton.centerYAnchor.constraint(equalTo: termsButton.centerYAnchor),
            privacyButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            privacyButton.heightAnchor.constraint(equalToConstant: 24),
            privacyButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        isChecked = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func toggle() {
        isChecked.toggle()
        sendActions(for: .valueChanged)
    }

    private func makeAgreementText() -> NSAttributedString {
        let text = "I have read and agree to Terms of Service and Privacy Policy."
        let result = NSMutableAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.black
            ]
        )
        ["Terms of Service", "Privacy Policy"].forEach { part in
            let range = (text as NSString).range(of: part)
            result.addAttributes([
                .font: UIFont.italicSystemFont(ofSize: 13),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ], range: range)
        }
        return result
    }

    @objc private func openTerms() {
        onTermsTapped?()
    }

    @objc private func openPrivacy() {
        onPrivacyTapped?()
    }
}
