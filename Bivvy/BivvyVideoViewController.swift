import UIKit

final class BivvyVideoViewController: UIViewController {
    private let categories = ["For you", "Fun", "Friend"]
    private var selectedCategoryIndex = 0
    private var currentIndex = 0
    private var allVideos: [BivvyVideoItem] = []
    private var visibleVideos: [BivvyVideoItem] = []
    private var likedVideoIds: Set<String> = []

    private let topTabs = UIStackView()
    private var tabButtons: [UIButton] = []
    private let shadowCard = UIImageView(image: UIImage.init(named: "shadowCard"))
    private let card = UIView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let coverImageView = UIImageView()
    private let emptyLabel = UILabel()
   
    private let saveButton = UIButton()
    private let commentButton = UIButton()
    private let playButton = UIButton()
    private let moreButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        visibleVideos = videosForSelectedCategory()
        buildLayout()
        renderCurrentVideo()
        loadVideos()
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
        view.addSubview(emptyLabel)
        shadowCard.addSubview(card)

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.text = "No data available."
        emptyLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        emptyLabel.textColor = UIColor.black.withAlphaComponent(0.48)
        emptyLabel.textAlignment = .center
        emptyLabel.isHidden = true

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
            card.bottomAnchor.constraint(equalTo: shadowCard.bottomAnchor),

            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
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
        shadowCard.isUserInteractionEnabled = true
        shadowCard.transform = CGAffineTransform(rotationAngle: -0.055)

        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .black
        card.layer.cornerRadius = 36
        card.layer.masksToBounds = true
        card.transform = CGAffineTransform(rotationAngle: 0.055)

        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.image = UIImage(named: "bivvy_video_cover_featured")
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.layer.cornerRadius = 24

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        nameLabel.textColor = .white
        nameLabel.adjustsFontSizeToFitWidth = true

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .bold)
        descriptionLabel.textColor = UIColor.white.withAlphaComponent(0.72)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        descriptionLabel.layer.cornerRadius = 14
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
            nameLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 28),
            nameLabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -16),

            moreButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18),
            moreButton.widthAnchor.constraint(equalToConstant: 36),
            moreButton.heightAnchor.constraint(equalToConstant: 36),

            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 28),
            descriptionLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -28),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),

            coverImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            coverImageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 8),
            coverImageView.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -8),
            coverImageView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -8),

            playButton.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -30),
            playButton.widthAnchor.constraint(equalToConstant: 70),
            playButton.heightAnchor.constraint(equalToConstant: 70),

     
            saveButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -36),
            saveButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 70),
            saveButton.heightAnchor.constraint(equalToConstant: 70),

            commentButton.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 36),
            commentButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            commentButton.widthAnchor.constraint(equalToConstant: 70),
            commentButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        [commentButton, playButton, saveButton, moreButton].forEach(card.bringSubviewToFront)
    }

    private func configureIconButton(_ button: UIButton, systemName: String) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: systemName), for: .normal)
       
    }

    private func videosForSelectedCategory() -> [BivvyVideoItem] {
        let category = categories[selectedCategoryIndex]
        let filtered = allVideos.filter { $0.category == category }
        return filtered
    }

    private func renderCurrentVideo() {
        guard !visibleVideos.isEmpty else {
            card.isHidden = true
            shadowCard.isHidden = true
            emptyLabel.isHidden = false
            coverImageView.image = UIImage(named: "bivvy_video_cover_featured")
            nameLabel.text = nil
            descriptionLabel.text = nil
            return
        }
        card.isHidden = false
        shadowCard.isHidden = false
        emptyLabel.isHidden = true
        currentIndex = min(currentIndex, visibleVideos.count - 1)
        let item = visibleVideos[currentIndex]
        nameLabel.text = item.userName
        descriptionLabel.text = "  \(item.description)"
        BivvyRemoteImageLoader.shared.load(item.coverURL, into: coverImageView, placeholder: UIImage(named: item.coverImageName))
        updateLikeVisual(for: item)
    }

    private func loadVideos() {
        BivvyNetworkService.shared.fetchVideos(page: 1) { [weak self] result in
            guard let self else { return }
            if case .success(let videos) = result {
                self.allVideos = videos
                self.currentIndex = 0
                self.visibleVideos = self.videosForSelectedCategory()
                self.renderCurrentVideo()
            }
        }
    }

    private func updateLikeVisual(for item: BivvyVideoItem) {
        let isLiked = likedVideoIds.contains(item.id) || item.isLiked
       
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
        alert.addAction(UIAlertAction(title: "Report", style: .destructive) { [weak self] _ in
            self?.openReport()
        })
        alert.addAction(UIAlertAction(title: "Block", style: .destructive) { [weak self] _ in
            self?.blockCurrentVideo()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        if let popover = alert.popoverPresentationController {
            popover.sourceView = moreButton
            popover.sourceRect = moreButton.bounds
        }
        present(alert, animated: true)
    }

    private func openReport() {
        guard !visibleVideos.isEmpty, let url = BivvyH5Route.report(dynamicId: visibleVideos[currentIndex].id).url() else { return }
        let web = BivvyWebViewController(url: url)
        web.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(web, animated: true)
    }

    private func blockCurrentVideo() {
        guard !visibleVideos.isEmpty else { return }
        let item = visibleVideos[currentIndex]
        BivvyNetworkService.shared.block(userId: item.userId, userName: item.userName, userImageURL: item.userAvatarURL)
        allVideos.removeAll { $0.id == item.id || (!$0.userId.isEmpty && $0.userId == item.userId) }
        visibleVideos = videosForSelectedCategory()
        currentIndex = min(currentIndex, max(0, visibleVideos.count - 1))
        renderCurrentVideo()
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
                    let dynamicId = visibleVideos[currentIndex].id
                    likedVideoIds.insert(dynamicId)
                    BivvyNetworkService.shared.like(dynamicId: dynamicId)
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
