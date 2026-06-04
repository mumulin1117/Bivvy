import UIKit

enum BivvyAuthTheme {
    static let violet = UIColor(red: 165 / 255, green: 135 / 255, blue: 255 / 255, alpha: 1)
    static let pink = UIColor(red: 255 / 255, green: 151 / 255, blue: 233 / 255, alpha: 1)
    static let hotPink = UIColor(red: 252 / 255, green: 69 / 255, blue: 126 / 255, alpha: 1)
    static let ink = UIColor(red: 21 / 255, green: 3 / 255, blue: 55 / 255, alpha: 1)
    static let mutedText = UIColor(red: 0, green: 0, blue: 0, alpha: 0.39)
    static let softPanel = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)

    static func displayFont(size: CGFloat) -> UIFont {
        UIFont(name: "SeasideResortNF", size: size) ?? .systemFont(ofSize: size, weight: .heavy)
    }

    static func titleFont(size: CGFloat) -> UIFont {
        UIFont.italicSystemFont(ofSize: size).withWeight(.heavy)
    }

    static func buttonFont(size: CGFloat) -> UIFont {
        UIFont.italicSystemFont(ofSize: size).withWeight(.heavy)
    }
}

private extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let descriptor = fontDescriptor.addingAttributes([
            .traits: [UIFontDescriptor.TraitKey.weight: weight]
        ])
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
