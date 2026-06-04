import UIKit

final class BivvyRemoteImageLoader {
    static let shared = BivvyRemoteImageLoader()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func load(_ urlString: String?, into imageView: UIImageView, placeholder: UIImage? = nil) {
        imageView.image = placeholder
        guard let urlString, let url = URL(string: urlString) else { return }

        let key = urlString as NSString
        if let cached = cache.object(forKey: key) {
            imageView.image = cached
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self, weak imageView] data, _, _ in
            guard let data, let image = UIImage(data: data) else { return }
            self?.cache.setObject(image, forKey: key)
            DispatchQueue.main.async {
                imageView?.image = image
            }
        }.resume()
    }
}
