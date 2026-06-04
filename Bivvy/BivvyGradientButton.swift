import UIKit

final class BivvyGradientButton: UIButton {
    private let gradientView = BivvyGradientView()
    private let spinner = UIActivityIndicatorView(style: .medium)

    var isLoading = false {
        didSet {
            isUserInteractionEnabled = !isLoading && isEnabled
            spinner.isHidden = !isLoading
            isLoading ? spinner.startAnimating() : spinner.stopAnimating()
            titleLabel?.alpha = isLoading ? 0 : 1
        }
    }

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.45
        }
    }

    init(title: String, style: Style = .gradient) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        titleLabel?.font = BivvyAuthTheme.buttonFont(size: 18)
        layer.cornerRadius = 26
        layer.masksToBounds = true
        gradientView.isUserInteractionEnabled = false
        spinner.isUserInteractionEnabled = false

        if style == .gradient {
            insertSubview(gradientView, at: 0)
        } else {
            backgroundColor = .black
        }

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.hidesWhenStopped = true
        spinner.isHidden = true
        addSubview(spinner)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 52),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView.frame = bounds
    }

    enum Style {
        case gradient
        case black
    }
}
