import UIKit

enum CommunitySharingAuthTheme {
    static let recommendationFeedViolet = UIColor(red: 165 / 255, green: 135 / 255, blue: 255 / 255, alpha: 1)
    static let productHighlightPink = UIColor(red: 255 / 255, green: 151 / 255, blue: 233 / 255, alpha: 1)
    static let favoriteFindPink = UIColor(red: 252 / 255, green: 69 / 255, blue: 126 / 255, alpha: 1)
    static let trustedReviewInk = UIColor(red: 21 / 255, green: 3 / 255, blue: 55 / 255, alpha: 1)
    static let contentFilteringMutedText = UIColor(red: 0, green: 0, blue: 0, alpha: 0.39)
    static let communityHubSoftPanel = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)

    static func dailyInspirationDisplayFont(size: CGFloat) -> UIFont {
        UIFont(name: "SeasideResortNF", size: size) ?? .systemFont(ofSize: size, weight: .heavy)
    }

    static func productShowcaseTitleFont(size: CGFloat) -> UIFont {
        UIFont.italicSystemFont(ofSize: size).withProductReviewWeight(.heavy)
    }

    static func sharingMechanicButtonFont(size: CGFloat) -> UIFont {
        UIFont.italicSystemFont(ofSize: size).withProductReviewWeight(.heavy)
    }
}

typealias BivvyAuthTheme = CommunitySharingAuthTheme

private extension UIFont {
    func withProductReviewWeight(_ trustedReviewWeight: UIFont.Weight) -> UIFont {
        let authenticReviewDescriptor = fontDescriptor.addingAttributes([
            .traits: [UIFontDescriptor.TraitKey.weight: trustedReviewWeight]
        ])
        return UIFont(descriptor: authenticReviewDescriptor, size: pointSize)
    }
}
