import UIKit

final class BivvyVideoActionButton: UIControl {
    private let iconView = UIImageView()
    private let countLabel = UILabel()

    init(systemName: String, count: String) {
        super.init(frame: .zero)
        iconView.image = UIImage(systemName: systemName)
        countLabel.text = count
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCount(_ count: String) {
        countLabel.text = count
    }

    private func buildLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        iconView.tintColor = .white
        iconView.contentMode = .scaleAspectFit
        countLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        countLabel.textColor = .white
        countLabel.textAlignment = .center

        addSubview(iconView)
        addSubview(countLabel)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 52),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.heightAnchor.constraint(equalToConstant: 30),

            countLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 5),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
