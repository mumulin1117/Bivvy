import UIKit

final class ProductCurationGradientView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    var curatedListColors: [UIColor] = [
        CommunitySharingAuthTheme.recommendationFeedViolet,
        CommunitySharingAuthTheme.productHighlightPink
    ] {
        didSet { refreshProductHighlightGradient() }
    }

    var productCurationStartPoint = CGPoint(x: 0.2, y: 0) {
        didSet { refreshProductHighlightGradient() }
    }

    var productCurationEndPoint = CGPoint(x: 0.84, y: 0.5) {
        didSet { refreshProductHighlightGradient() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        refreshProductHighlightGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        refreshProductHighlightGradient()
    }

    private func refreshProductHighlightGradient() {
        guard let productHighlightLayer = layer as? CAGradientLayer else { return }
        productHighlightLayer.colors = curatedListColors.map(\.cgColor)
        productHighlightLayer.startPoint = productCurationStartPoint
        productHighlightLayer.endPoint = productCurationEndPoint
    }
}

typealias BivvyGradientView = ProductCurationGradientView
