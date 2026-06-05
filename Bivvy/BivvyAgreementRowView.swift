import UIKit

final class SharedInterestAgreementRowView: UIControl {
    private let sharedInterestCheckImageView = UIImageView()
    private let consciousSharingLabel = UILabel()
    private let productDiscussionTermsButton = UIButton(type: .system)
    private let trustedVoicePrivacyButton = UIButton(type: .system)

    var productDiscussionTapped: (() -> Void)?
    var trustedVoiceTapped: (() -> Void)?

    var sharedInterestAccepted = false {
        didSet {
            sharedInterestCheckImageView.image = UIImage(named: sharedInterestAccepted ? "bivvy_auth_agreement_active" : "bivvy_auth_agreement_idle")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(toggleSharedInterestAgreement), for: .touchUpInside)

        sharedInterestCheckImageView.translatesAutoresizingMaskIntoConstraints = false
        sharedInterestCheckImageView.contentMode = .scaleAspectFit
        addSubview(sharedInterestCheckImageView)

        consciousSharingLabel.translatesAutoresizingMaskIntoConstraints = false
        consciousSharingLabel.numberOfLines = 0
        consciousSharingLabel.text = "I have read and agree to"
        consciousSharingLabel.font = .systemFont(ofSize: 13)
        consciousSharingLabel.textColor = .gray
        addSubview(consciousSharingLabel)

        productDiscussionTermsButton.translatesAutoresizingMaskIntoConstraints = false
        productDiscussionTermsButton.setTitle("Terms of Service", for: .normal)
        productDiscussionTermsButton.titleLabel?.font = .italicSystemFont(ofSize: 13)
        productDiscussionTermsButton.setTitleColor(.black, for: .normal)
        productDiscussionTermsButton.addTarget(self, action: #selector(openProductDiscussionTerms), for: .touchUpInside)
        addSubview(productDiscussionTermsButton)

        trustedVoicePrivacyButton.translatesAutoresizingMaskIntoConstraints = false
        trustedVoicePrivacyButton.setTitle("Privacy Policy", for: .normal)
        trustedVoicePrivacyButton.titleLabel?.font = .italicSystemFont(ofSize: 13)
        trustedVoicePrivacyButton.setTitleColor(.black, for: .normal)
        trustedVoicePrivacyButton.addTarget(self, action: #selector(openTrustedVoicePrivacy), for: .touchUpInside)
        addSubview(trustedVoicePrivacyButton)

        NSLayoutConstraint.activate([
            sharedInterestCheckImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sharedInterestCheckImageView.topAnchor.constraint(equalTo: topAnchor),
            sharedInterestCheckImageView.widthAnchor.constraint(equalToConstant: 24),
            sharedInterestCheckImageView.heightAnchor.constraint(equalToConstant: 24),

            consciousSharingLabel.leadingAnchor.constraint(equalTo: sharedInterestCheckImageView.trailingAnchor, constant: 12),
            consciousSharingLabel.topAnchor.constraint(equalTo: topAnchor, constant: -1),
            consciousSharingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            productDiscussionTermsButton.leadingAnchor.constraint(equalTo: consciousSharingLabel.leadingAnchor),
            productDiscussionTermsButton.topAnchor.constraint(equalTo: consciousSharingLabel.bottomAnchor, constant: 2),
            productDiscussionTermsButton.heightAnchor.constraint(equalToConstant: 24),

            trustedVoicePrivacyButton.leadingAnchor.constraint(equalTo: productDiscussionTermsButton.trailingAnchor, constant: 10),
            trustedVoicePrivacyButton.centerYAnchor.constraint(equalTo: productDiscussionTermsButton.centerYAnchor),
            trustedVoicePrivacyButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            trustedVoicePrivacyButton.heightAnchor.constraint(equalToConstant: 24),
            trustedVoicePrivacyButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        sharedInterestAccepted = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func toggleSharedInterestAgreement() {
        sharedInterestAccepted.toggle()
        sendActions(for: .valueChanged)
    }

    private func makeConsciousSharingAgreementText() -> NSAttributedString {
        let sharedInterestText = "I have read and agree to Terms of Service and Privacy Policy."
        let meaningfulConnectionResult = NSMutableAttributedString(
            string: sharedInterestText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor.black
            ]
        )
        ["Terms of Service", "Privacy Policy"].forEach { productDiscussionPart in
            let trustedVoiceRange = (sharedInterestText as NSString).range(of: productDiscussionPart)
            meaningfulConnectionResult.addAttributes([
                .font: UIFont.italicSystemFont(ofSize: 13),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ], range: trustedVoiceRange)
        }
        return meaningfulConnectionResult
    }

    @objc private func openProductDiscussionTerms() {
        productDiscussionTapped?()
    }

    @objc private func openTrustedVoicePrivacy() {
        trustedVoiceTapped?()
    }
}

typealias BivvyAgreementRowView = SharedInterestAgreementRowView
