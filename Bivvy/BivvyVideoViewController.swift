import UIKit

final class BivvyVideoViewController: UIViewController {
    private let categories = ["For you", "Fun", "Friend"]
    private var selectedCategoryIndex = 0
    private var currentIndex = 0
    private var allVideos = BivvyMockContent.videos
    private var visibleVideos: [BivvyVideoItem] = []
    private var likedVideoIds: Set<String> = []

    private let topTabs = UIStackView()
    private var tabButtons: [UIButton] = []
    private let shadowCard = UIImageView(image: UIImage.init(named: "shadowCard"))
    private let card = UIView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let coverImageView = UIImageView()
   
    private let saveButton = UIButton(type: .system)
    private let commentButton = UIButton(type: .system)
    private let playButton = UIButton(type: .system)
    private let moreButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        visibleVideos = videosForSelectedCategory()
        buildLayout()
        renderCurrentVideo()
    }

    private func buildLayout() {
        view.backgroundColor = .white
        shadowCard.contentMode = .scaleToFill
        let background = BivvyGradientView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.colors = [
            UIColor(red: 255 / 255, green: 205 / 255, blue: 215 / 255, alpha: 1),
            UIColor(red: 255 / 255, green: 246 / 255, blue: 251 / 255, alpha: 1),
            UIColor.white
        ]
        background.startPoint = CGPoint(x: 0, y: 0)
        background.endPoint = CGPoint(x: 0.92, y: 0.58)

        configureTopTabs()
        configureCard()

        view.addSubview(background)
        view.addSubview(topTabs)
        view.addSubview(shadowCard)
        shadowCard.addSubview(card)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            topTabs.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            topTabs.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            topTabs.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            topTabs.heightAnchor.constraint(equalToConstant: 40),

            shadowCard.topAnchor.constraint(equalTo: topTabs.bottomAnchor, constant: 12),
            shadowCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            shadowCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            shadowCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),

            card.topAnchor.constraint(equalTo: shadowCard.topAnchor, constant: 20),
            card.leadingAnchor.constraint(equalTo: shadowCard.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: shadowCard.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: shadowCard.bottomAnchor)
        ])
    }

    private func configureTopTabs() {
        topTabs.translatesAutoresizingMaskIntoConstraints = false
        topTabs.axis = .horizontal
        topTabs.distribution = .fillEqually
        topTabs.spacing = 20

        for (index, title) in categories.enumerated() {
            var configuration = UIButton.Configuration.filled()
            configuration.title = title
            configuration.cornerStyle = .capsule
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 10, bottom: 14, trailing: 10)
            let button = UIButton(configuration: configuration)
            button.tag = index
            button.titleLabel?.font = BivvyAuthTheme.buttonFont(size: 14)
            button.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
            tabButtons.append(button)
            topTabs.addArrangedSubview(button)
        }
        updateTabButtons()
    }

    private func configureCard() {
        shadowCard.translatesAutoresizingMaskIntoConstraints = false
//        shadowCard.
        shadowCard.transform = CGAffineTransform(rotationAngle: -0.055)

        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .black
        card.layer.cornerRadius = 52
        card.layer.masksToBounds = true
        card.transform = CGAffineTransform(rotationAngle: 0.055)

        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.layer.cornerRadius = 28

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 38, weight: .heavy)
        nameLabel.textColor = .white
        nameLabel.adjustsFontSizeToFitWidth = true

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 18, weight: .bold)
        descriptionLabel.textColor = UIColor.white.withAlphaComponent(0.72)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        descriptionLabel.layer.cornerRadius = 16
        descriptionLabel.layer.masksToBounds = true

        configureIconButton(playButton, systemName: "vioeaply")
      
        configureIconButton(saveButton, systemName: "videoUnheaer")
        configureIconButton(commentButton, systemName: "videoUncomment",)
        configureIconButton(moreButton, systemName: "videoUnMore")

        [ saveButton, commentButton, playButton].forEach {
            $0.addTarget(self, action: #selector(openCurrentVideoDetail), for: .touchUpInside)
        }
        moreButton.addTarget(self, action: #selector(showMoreActions), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(openCurrentVideoDetail))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        card.addGestureRecognizer(tap)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(_:)))
        pan.delegate = self
        card.addGestureRecognizer(pan)

        [nameLabel, descriptionLabel, coverImageView, moreButton, commentButton, playButton, saveButton].forEach(card.addSubview)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 46),
            nameLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 40),
            nameLabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -16),

            moreButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -26),
            moreButton.widthAnchor.constraint(equalToConstant: 44),
            moreButton.heightAnchor.constraint(equalToConstant: 44),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -40),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 84),

            coverImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            coverImageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 8),
            coverImageView.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -8),
            coverImageView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -8),

            playButton.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 88),
            playButton.heightAnchor.constraint(equalToConstant: 88),

     
            saveButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -48),
            saveButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 88),
            saveButton.heightAnchor.constraint(equalToConstant: 88),

            commentButton.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 48),
            commentButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            commentButton.widthAnchor.constraint(equalToConstant: 88),
            commentButton.heightAnchor.constraint(equalToConstant: 88)
        ])
    }

    private func configureIconButton(_ button: UIButton, systemName: String) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: systemName), for: .normal)
       
    }

    private func videosForSelectedCategory() -> [BivvyVideoItem] {
        let category = categories[selectedCategoryIndex]
        let filtered = allVideos.filter { $0.category == category }
        return filtered.isEmpty ? allVideos : filtered
    }

    private func renderCurrentVideo() {
        guard !visibleVideos.isEmpty else { return }
        currentIndex = min(currentIndex, visibleVideos.count - 1)
        let item = visibleVideos[currentIndex]
        nameLabel.text = item.userName
        descriptionLabel.text = "  \(item.description)"
        coverImageView.image = UIImage(named: item.coverImageName)
        updateLikeVisual(for: item)
    }

    private func updateLikeVisual(for item: BivvyVideoItem) {
        let isLiked = likedVideoIds.contains(item.id) || item.isLiked
        saveButton.alpha = isLiked ? 1 : 0.82
        saveButton.transform = isLiked ? CGAffineTransform(scaleX: 1.04, y: 1.04) : .identity
        saveButton.isSelected = true
    
    }

    private func updateTabButtons() {
        for button in tabButtons {
            let selected = button.tag == selectedCategoryIndex
            var configuration = button.configuration
            configuration?.baseBackgroundColor = selected ? UIColor(red: 248 / 255, green: 66 / 255, blue: 124 / 255, alpha: 1) : .white
            configuration?.baseForegroundColor = selected ? .white : .black
            button.configuration = configuration
            
        }
    }

    private func advanceToNextCard() {
        guard !visibleVideos.isEmpty else { return }
        currentIndex = (currentIndex + 1) % visibleVideos.count
        UIView.transition(with: card, duration: 0.22, options: [.transitionCrossDissolve, .allowUserInteraction]) {
            self.renderCurrentVideo()
        }
    }

    private func pushVideoDetail() {
        guard !visibleVideos.isEmpty, let url = BivvyH5Route.videoDetail(dynamicId: visibleVideos[currentIndex].id).url() else { return }
        let web = BivvyWebViewController(url: url)
        web.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(web, animated: true)
    }

    @objc private func selectCategory(_ sender: UIButton) {
        selectedCategoryIndex = sender.tag
        currentIndex = 0
        visibleVideos = videosForSelectedCategory()
        updateTabButtons()
        renderCurrentVideo()
    }

    @objc private func openCurrentVideoDetail() {
        pushVideoDetail()
    }

    @objc private func showMoreActions() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Report", style: .destructive))
        alert.addAction(UIAlertAction(title: "Block", style: .destructive))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        if let popover = alert.popoverPresentationController {
            popover.sourceView = moreButton
            popover.sourceRect = moreButton.bounds
        }
        present(alert, animated: true)
    }

    @objc private func handleCardPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        switch gesture.state {
        case .changed:
            let rotation = translation.x / view.bounds.width * 0.18
            card.transform = CGAffineTransform(translationX: translation.x * 0.52, y: 0).rotated(by: rotation)
        case .ended, .cancelled:
            let shouldAdvance = abs(translation.x) > 90
            if shouldAdvance {
                if translation.x > 0, !visibleVideos.isEmpty {
                    likedVideoIds.insert(visibleVideos[currentIndex].id)
                }
                let direction: CGFloat = translation.x >= 0 ? 1 : -1
                UIView.animate(withDuration: 0.18, animations: {
                    self.card.transform = CGAffineTransform(translationX: direction * self.view.bounds.width, y: 0).rotated(by: direction * 0.2)
                    self.card.alpha = 0.4
                }, completion: { _ in
                    self.card.transform = CGAffineTransform(translationX: -direction * self.view.bounds.width * 0.32, y: 0)
                    self.advanceToNextCard()
                    UIView.animate(withDuration: 0.18) {
                        self.card.transform = .identity
                        self.card.alpha = 1
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.card.transform = .identity
                }
            }
        default:
            break
        }
    }
}

extension BivvyVideoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        !(touch.view is UIControl)
    }
}
