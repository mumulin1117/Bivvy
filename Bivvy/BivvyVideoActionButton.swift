import UIKit

final class VideoEngagementActionButton: UIControl {
    private let videoEngagementIconView = UIImageView()
    private let engagementMetricCountLabel = UILabel()

    init(systemName: String, count: String) {
        super.init(frame: .zero)
        videoEngagementIconView.image = UIImage(systemName: systemName)
        engagementMetricCountLabel.text = count
        buildVideoEngagementLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCount(_ count: String) {
        engagementMetricCountLabel.text = count
    }

    private func buildVideoEngagementLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        videoEngagementIconView.translatesAutoresizingMaskIntoConstraints = false
        engagementMetricCountLabel.translatesAutoresizingMaskIntoConstraints = false

        videoEngagementIconView.tintColor = .white
        videoEngagementIconView.contentMode = .scaleAspectFit
        engagementMetricCountLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        engagementMetricCountLabel.textColor = .white
        engagementMetricCountLabel.textAlignment = .center

        addSubview(videoEngagementIconView)
        addSubview(engagementMetricCountLabel)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 52),
            videoEngagementIconView.topAnchor.constraint(equalTo: topAnchor),
            videoEngagementIconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            videoEngagementIconView.widthAnchor.constraint(equalToConstant: 30),
            videoEngagementIconView.heightAnchor.constraint(equalToConstant: 30),

            engagementMetricCountLabel.topAnchor.constraint(equalTo: videoEngagementIconView.bottomAnchor, constant: 5),
            engagementMetricCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            engagementMetricCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            engagementMetricCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

typealias BivvyVideoActionButton = VideoEngagementActionButton
