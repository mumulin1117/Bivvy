import UIKit

final class BivvyGradientView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    var colors: [UIColor] = [BivvyAuthTheme.violet, BivvyAuthTheme.pink] {
        didSet { updateGradient() }
    }

    var startPoint = CGPoint(x: 0.2, y: 0) {
        didSet { updateGradient() }
    }

    var endPoint = CGPoint(x: 0.84, y: 0.5) {
        didSet { updateGradient() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        updateGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateGradient()
    }

    private func updateGradient() {
        guard let gradientLayer = layer as? CAGradientLayer else { return }
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }
}
