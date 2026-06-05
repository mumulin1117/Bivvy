import UIKit

final class SharingMechanicGradientButton: UIButton {
    private let productHighlightGradientView = ProductCurationGradientView()
    private let recommendationEngineSpinner = UIActivityIndicatorView(style: .medium)

    var isSharingMechanicLoading = false {
        didSet {
            isUserInteractionEnabled = !isSharingMechanicLoading && isEnabled
            recommendationEngineSpinner.isHidden = !isSharingMechanicLoading
            isSharingMechanicLoading ? recommendationEngineSpinner.startAnimating() : recommendationEngineSpinner.stopAnimating()
            titleLabel?.alpha = isSharingMechanicLoading ? 0 : 1
        }
    }

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.45
        }
    }

    init(title productHighlightTitle: String, style: ProductHighlightStyle = .productHighlightGradient) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(productHighlightTitle, for: .normal)
        titleLabel?.font = CommunitySharingAuthTheme.sharingMechanicButtonFont(size: 18)
        layer.cornerRadius = 26
        layer.masksToBounds = true
        productHighlightGradientView.isUserInteractionEnabled = false
        recommendationEngineSpinner.isUserInteractionEnabled = false

        if style == .productHighlightGradient {
            insertSubview(productHighlightGradientView, at: 0)
        } else {
            backgroundColor = .black
        }

        recommendationEngineSpinner.translatesAutoresizingMaskIntoConstraints = false
        recommendationEngineSpinner.color = .white
        recommendationEngineSpinner.hidesWhenStopped = true
        recommendationEngineSpinner.isHidden = true
        addSubview(recommendationEngineSpinner)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 52),
            recommendationEngineSpinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            recommendationEngineSpinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        productHighlightGradientView.frame = bounds
    }

    enum ProductHighlightStyle {
        case productHighlightGradient
        case trustedReviewBlack
    }
}

typealias BivvyGradientButton = SharingMechanicGradientButton
