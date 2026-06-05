import UIKit

final class VideoDiscoveryFeedViewController: UIViewController {
    private let interestGroupTabs = ["For you", "Fun", "Friend"]
    private var selectedInterestGroupIndex = 0
    private var currentVideoSnippetIndex = 0
    private var videoDiscoverySnippets: [VideoDiscoverySnippetItem] = []
    private var visibleVideoSnippets: [VideoDiscoverySnippetItem] = []
    private var savedVideoEngagementIds: Set<String> = []

    private let interestGroupTabStack = UIStackView()
    private var interestGroupButtons: [UIButton] = []
    private let videoSnippetShadowCard = UIImageView(image: UIImage.init(named: "shadowCard"))
    private let videoSnippetCard = UIView()
    private let contentCreatorNameLabel = UILabel()
    private let authenticReviewLabel = UILabel()
    private let videoSnippetCoverView = UIImageView()
    private let emptyVideoFeedLabel = UILabel()
   
    private let savedItemButton = UIButton()
    private let discussionStarterButton = UIButton()
    private let videoStreamingPlayButton = UIButton()
    private let contentFilteringMoreButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        visibleVideoSnippets = videoSnippetsForSelectedInterestGroup()
        buildVideoDiscoveryLayout()
        renderCurrentVideoSnippet()
        loadVideoDiscoverySnippets()
    }

    private func buildVideoDiscoveryLayout() {
        view.backgroundColor = .white
        videoSnippetShadowCard.contentMode = .scaleToFill
        let videoDiscoveryBackground = ProductCurationGradientView()
        videoDiscoveryBackground.translatesAutoresizingMaskIntoConstraints = false
        videoDiscoveryBackground.curatedListColors = [
            UIColor(red: 255 / 255, green: 205 / 255, blue: 215 / 255, alpha: 1),
            UIColor(red: 255 / 255, green: 246 / 255, blue: 251 / 255, alpha: 1),
            UIColor.white
        ]
        videoDiscoveryBackground.productCurationStartPoint = CGPoint(x: 0, y: 0)
        videoDiscoveryBackground.productCurationEndPoint = CGPoint(x: 0.92, y: 0.58)

        configureInterestGroupTabs()
        configureVideoSnippetCard()

        view.addSubview(videoDiscoveryBackground)
        view.addSubview(interestGroupTabStack)
        view.addSubview(videoSnippetShadowCard)
        view.addSubview(emptyVideoFeedLabel)
        videoSnippetShadowCard.addSubview(videoSnippetCard)

        emptyVideoFeedLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyVideoFeedLabel.text = BivvyStringVault.noData
        emptyVideoFeedLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        emptyVideoFeedLabel.textColor = UIColor.black.withAlphaComponent(0.48)
        emptyVideoFeedLabel.textAlignment = .center
        emptyVideoFeedLabel.isHidden = true

        NSLayoutConstraint.activate([
            videoDiscoveryBackground.topAnchor.constraint(equalTo: view.topAnchor),
            videoDiscoveryBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoDiscoveryBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoDiscoveryBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            interestGroupTabStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            interestGroupTabStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            interestGroupTabStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            interestGroupTabStack.heightAnchor.constraint(equalToConstant: 40),

            videoSnippetShadowCard.topAnchor.constraint(equalTo: interestGroupTabStack.bottomAnchor, constant: 12),
            videoSnippetShadowCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            videoSnippetShadowCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            videoSnippetShadowCard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),

            videoSnippetCard.topAnchor.constraint(equalTo: videoSnippetShadowCard.topAnchor, constant: 20),
            videoSnippetCard.leadingAnchor.constraint(equalTo: videoSnippetShadowCard.leadingAnchor),
            videoSnippetCard.trailingAnchor.constraint(equalTo: videoSnippetShadowCard.trailingAnchor),
            videoSnippetCard.bottomAnchor.constraint(equalTo: videoSnippetShadowCard.bottomAnchor),

            emptyVideoFeedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyVideoFeedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyVideoFeedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emptyVideoFeedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func configureInterestGroupTabs() {
        interestGroupTabStack.translatesAutoresizingMaskIntoConstraints = false
        interestGroupTabStack.axis = .horizontal
        interestGroupTabStack.distribution = .fillEqually
        interestGroupTabStack.spacing = 20

        for (interestGroupIndex, sharedInterestTitle) in interestGroupTabs.enumerated() {
            var sharedInterestConfiguration = UIButton.Configuration.filled()
            sharedInterestConfiguration.title = sharedInterestTitle
            sharedInterestConfiguration.cornerStyle = .capsule
            sharedInterestConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 10, bottom: 14, trailing: 10)
            let sharedInterestButton = UIButton(configuration: sharedInterestConfiguration)
            sharedInterestButton.tag = interestGroupIndex
            sharedInterestButton.titleLabel?.font = CommunitySharingAuthTheme.sharingMechanicButtonFont(size: 14)
            sharedInterestButton.addTarget(self, action: #selector(selectInterestGroup(_:)), for: .touchUpInside)
            interestGroupButtons.append(sharedInterestButton)
            interestGroupTabStack.addArrangedSubview(sharedInterestButton)
        }
        updateInterestGroupButtons()
    }

    private func configureVideoSnippetCard() {
        videoSnippetShadowCard.translatesAutoresizingMaskIntoConstraints = false
        videoSnippetShadowCard.isUserInteractionEnabled = true
        videoSnippetShadowCard.transform = CGAffineTransform(rotationAngle: -0.055)

        videoSnippetCard.translatesAutoresizingMaskIntoConstraints = false
        videoSnippetCard.backgroundColor = .black
        videoSnippetCard.layer.cornerRadius = 36
        videoSnippetCard.layer.masksToBounds = true
        videoSnippetCard.transform = CGAffineTransform(rotationAngle: 0.055)

        videoSnippetCoverView.translatesAutoresizingMaskIntoConstraints = false
        videoSnippetCoverView.image = UIImage(named: "bivvy_video_cover_featured")
        videoSnippetCoverView.contentMode = .scaleAspectFill
        videoSnippetCoverView.clipsToBounds = true
        videoSnippetCoverView.layer.cornerRadius = 24

        contentCreatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentCreatorNameLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        contentCreatorNameLabel.textColor = .white
        contentCreatorNameLabel.adjustsFontSizeToFitWidth = true

        authenticReviewLabel.translatesAutoresizingMaskIntoConstraints = false
        authenticReviewLabel.font = .systemFont(ofSize: 15, weight: .bold)
        authenticReviewLabel.textColor = UIColor.white.withAlphaComponent(0.72)
        authenticReviewLabel.numberOfLines = 2
        authenticReviewLabel.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        authenticReviewLabel.layer.cornerRadius = 14
        authenticReviewLabel.layer.masksToBounds = true

        configureVideoActionIcon(videoStreamingPlayButton, assetName: "vioeaply")
      
        configureVideoActionIcon(savedItemButton, assetName: "videoUnheaer")
        configureVideoActionIcon(discussionStarterButton, assetName: "videoUncomment")
        configureVideoActionIcon(contentFilteringMoreButton, assetName: "videoUnMore")

        [savedItemButton, discussionStarterButton, videoStreamingPlayButton].forEach {
            $0.addTarget(self, action: #selector(openCurrentVideoDetail), for: .touchUpInside)
        }
        contentFilteringMoreButton.addTarget(self, action: #selector(showContentFilteringActions), for: .touchUpInside)

        let videoDetailTap = UITapGestureRecognizer(target: self, action: #selector(openCurrentVideoDetail))
        videoDetailTap.cancelsTouchesInView = false
        videoDetailTap.delegate = self
        videoSnippetCard.addGestureRecognizer(videoDetailTap)

        let videoCardPan = UIPanGestureRecognizer(target: self, action: #selector(handleVideoSnippetPan(_:)))
        videoCardPan.delegate = self
        videoSnippetCard.addGestureRecognizer(videoCardPan)

        [contentCreatorNameLabel, authenticReviewLabel, videoSnippetCoverView, contentFilteringMoreButton, discussionStarterButton, videoStreamingPlayButton, savedItemButton].forEach(videoSnippetCard.addSubview)

        NSLayoutConstraint.activate([
            contentCreatorNameLabel.topAnchor.constraint(equalTo: videoSnippetCard.topAnchor, constant: 30),
            contentCreatorNameLabel.leadingAnchor.constraint(equalTo: videoSnippetCard.leadingAnchor, constant: 28),
            contentCreatorNameLabel.trailingAnchor.constraint(equalTo: contentFilteringMoreButton.leadingAnchor, constant: -16),

            contentFilteringMoreButton.centerYAnchor.constraint(equalTo: contentCreatorNameLabel.centerYAnchor),
            contentFilteringMoreButton.trailingAnchor.constraint(equalTo: videoSnippetCard.trailingAnchor, constant: -18),
            contentFilteringMoreButton.widthAnchor.constraint(equalToConstant: 36),
            contentFilteringMoreButton.heightAnchor.constraint(equalToConstant: 36),

            authenticReviewLabel.topAnchor.constraint(equalTo: contentCreatorNameLabel.bottomAnchor, constant: 16),
            authenticReviewLabel.leadingAnchor.constraint(equalTo: videoSnippetCard.leadingAnchor, constant: 28),
            authenticReviewLabel.trailingAnchor.constraint(equalTo: videoSnippetCard.trailingAnchor, constant: -28),
            authenticReviewLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),

            videoSnippetCoverView.topAnchor.constraint(equalTo: authenticReviewLabel.bottomAnchor, constant: 16),
            videoSnippetCoverView.leadingAnchor.constraint(equalTo: videoSnippetCard.leadingAnchor, constant: 8),
            videoSnippetCoverView.trailingAnchor.constraint(equalTo: videoSnippetCard.trailingAnchor, constant: -8),
            videoSnippetCoverView.bottomAnchor.constraint(equalTo: videoSnippetCard.bottomAnchor, constant: -8),

            videoStreamingPlayButton.centerXAnchor.constraint(equalTo: videoSnippetCard.centerXAnchor),
            videoStreamingPlayButton.bottomAnchor.constraint(equalTo: videoSnippetCard.bottomAnchor, constant: -30),
            videoStreamingPlayButton.widthAnchor.constraint(equalToConstant: 70),
            videoStreamingPlayButton.heightAnchor.constraint(equalToConstant: 70),

     
            savedItemButton.trailingAnchor.constraint(equalTo: videoSnippetCard.trailingAnchor, constant: -36),
            savedItemButton.centerYAnchor.constraint(equalTo: videoStreamingPlayButton.centerYAnchor),
            savedItemButton.widthAnchor.constraint(equalToConstant: 70),
            savedItemButton.heightAnchor.constraint(equalToConstant: 70),

            discussionStarterButton.leadingAnchor.constraint(equalTo: videoSnippetCard.leadingAnchor, constant: 36),
            discussionStarterButton.centerYAnchor.constraint(equalTo: videoStreamingPlayButton.centerYAnchor),
            discussionStarterButton.widthAnchor.constraint(equalToConstant: 70),
            discussionStarterButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        [discussionStarterButton, videoStreamingPlayButton, savedItemButton, contentFilteringMoreButton].forEach(videoSnippetCard.bringSubviewToFront)
    }

    private func configureVideoActionIcon(_ button: UIButton, assetName: String) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: assetName), for: .normal)
       
    }

    private func videoSnippetsForSelectedInterestGroup() -> [VideoDiscoverySnippetItem] {
        let sharedInterestCategory = interestGroupTabs[selectedInterestGroupIndex]
        let personalizedFeed = videoDiscoverySnippets.filter { $0.productCategoryName == sharedInterestCategory }
        return personalizedFeed
    }

    private func renderCurrentVideoSnippet() {
        guard !visibleVideoSnippets.isEmpty else {
            videoSnippetCard.isHidden = true
            videoSnippetShadowCard.isHidden = true
            emptyVideoFeedLabel.isHidden = false
            videoSnippetCoverView.image = UIImage(named: "bivvy_video_cover_featured")
            contentCreatorNameLabel.text = nil
            authenticReviewLabel.text = nil
            return
        }
        videoSnippetCard.isHidden = false
        videoSnippetShadowCard.isHidden = false
        emptyVideoFeedLabel.isHidden = true
        currentVideoSnippetIndex = min(currentVideoSnippetIndex, visibleVideoSnippets.count - 1)
        let videoSnippet = visibleVideoSnippets[currentVideoSnippetIndex]
        contentCreatorNameLabel.text = videoSnippet.contentCreatorName
        authenticReviewLabel.text = "  \(videoSnippet.authenticReviewDescription)"
        BivvyRemoteImageLoader.shared.load(videoSnippet.videoStreamingCoverURL, into: videoSnippetCoverView, placeholder: UIImage(named: videoSnippet.videoSnippetCoverImageName))
        updateVideoEngagementVisual(for: videoSnippet)
    }

    private func loadVideoDiscoverySnippets() {
        BivvyNetworkService.shared.fetchVideoDiscoverySnippets(page: 1) { [weak self] result in
            guard let self else { return }
            if case .success(let videoSnippets) = result {
                self.videoDiscoverySnippets = videoSnippets
                self.currentVideoSnippetIndex = 0
                self.visibleVideoSnippets = self.videoSnippetsForSelectedInterestGroup()
                self.renderCurrentVideoSnippet()
            }
        }
    }

    private func updateVideoEngagementVisual(for videoSnippet: VideoDiscoverySnippetItem) {
        let isSavedEngagement = savedVideoEngagementIds.contains(videoSnippet.productShowcaseId) || videoSnippet.videoEngagementIsLiked
       
        savedItemButton.transform = isSavedEngagement ? CGAffineTransform(scaleX: 1.04, y: 1.04) : .identity
        savedItemButton.isSelected = true
    
    }

    private func updateInterestGroupButtons() {
        for sharedInterestButton in interestGroupButtons {
            let isSharedInterestSelected = sharedInterestButton.tag == selectedInterestGroupIndex
            var sharedInterestConfiguration = sharedInterestButton.configuration
            sharedInterestConfiguration?.baseBackgroundColor = isSharedInterestSelected ? UIColor(red: 248 / 255, green: 66 / 255, blue: 124 / 255, alpha: 1) : .white
            sharedInterestConfiguration?.baseForegroundColor = isSharedInterestSelected ? .white : .black
            sharedInterestButton.configuration = sharedInterestConfiguration
            
        }
    }

    private func advanceToNextVideoSnippet() {
        guard !visibleVideoSnippets.isEmpty else { return }
        currentVideoSnippetIndex = (currentVideoSnippetIndex + 1) % visibleVideoSnippets.count
        UIView.transition(with: videoSnippetCard, duration: 0.22, options: [.transitionCrossDissolve, .allowUserInteraction]) {
            self.renderCurrentVideoSnippet()
        }
    }

    private func pushVideoSnippetDetail() {
        guard !visibleVideoSnippets.isEmpty, let productReviewURL = BivvyH5Route.videoSnippet(handpickedDynamicId: visibleVideoSnippets[currentVideoSnippetIndex].productShowcaseId).productCurationURL() else { return }
        let videoDiscoveryWebPage = BivvyWebViewController(url: productReviewURL)
        videoDiscoveryWebPage.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(videoDiscoveryWebPage, animated: true)
    }

    @objc private func selectInterestGroup(_ sender: UIButton) {
        selectedInterestGroupIndex = sender.tag
        currentVideoSnippetIndex = 0
        visibleVideoSnippets = videoSnippetsForSelectedInterestGroup()
        updateInterestGroupButtons()
        renderCurrentVideoSnippet()
    }

    @objc private func openCurrentVideoDetail() {
        pushVideoSnippetDetail()
    }

    @objc private func showContentFilteringActions() {
        let contentFilteringSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        contentFilteringSheet.addAction(UIAlertAction(title: BivvyStringVault.report, style: .destructive) { [weak self] _ in
            self?.openTrustedReviewReport()
        })
        contentFilteringSheet.addAction(UIAlertAction(title: BivvyStringVault.block, style: .destructive) { [weak self] _ in
            self?.blockCurrentVideoSnippet()
        })
        contentFilteringSheet.addAction(UIAlertAction(title: BivvyStringVault.cancel, style: .cancel))
        if let productDiscussionPopover = contentFilteringSheet.popoverPresentationController {
            productDiscussionPopover.sourceView = contentFilteringMoreButton
            productDiscussionPopover.sourceRect = contentFilteringMoreButton.bounds
        }
        present(contentFilteringSheet, animated: true)
    }

    private func openTrustedReviewReport() {
        guard !visibleVideoSnippets.isEmpty, let trustedReviewURL = BivvyH5Route.trustedReview(handpickedDynamicId: visibleVideoSnippets[currentVideoSnippetIndex].productShowcaseId).productCurationURL() else { return }
        let trustedReviewWebPage = BivvyWebViewController(url: trustedReviewURL)
        trustedReviewWebPage.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(trustedReviewWebPage, animated: true)
    }

    private func blockCurrentVideoSnippet() {
        guard !visibleVideoSnippets.isEmpty else { return }
        let videoSnippet = visibleVideoSnippets[currentVideoSnippetIndex]
        BivvyNetworkService.shared.blockPeerInteraction(userDiscoveryId: videoSnippet.userDiscoveryId, contentCreatorName: videoSnippet.contentCreatorName, contentCreatorAvatarURL: videoSnippet.contentCreatorAvatarURL)
        videoDiscoverySnippets.removeAll { $0.productShowcaseId == videoSnippet.productShowcaseId || (!$0.userDiscoveryId.isEmpty && $0.userDiscoveryId == videoSnippet.userDiscoveryId) }
        visibleVideoSnippets = videoSnippetsForSelectedInterestGroup()
        currentVideoSnippetIndex = min(currentVideoSnippetIndex, max(0, visibleVideoSnippets.count - 1))
        renderCurrentVideoSnippet()
    }

    @objc private func handleVideoSnippetPan(_ gesture: UIPanGestureRecognizer) {
        let peerInteractionTranslation = gesture.translation(in: view)
        switch gesture.state {
        case .changed:
            let videoEngagementRotation = peerInteractionTranslation.x / view.bounds.width * 0.18
            videoSnippetCard.transform = CGAffineTransform(translationX: peerInteractionTranslation.x * 0.52, y: 0).rotated(by: videoEngagementRotation)
        case .ended, .cancelled:
            let shouldAdvanceFeed = abs(peerInteractionTranslation.x) > 90
            if shouldAdvanceFeed {
                if peerInteractionTranslation.x > 0, !visibleVideoSnippets.isEmpty {
                    let handpickedDynamicId = visibleVideoSnippets[currentVideoSnippetIndex].productShowcaseId
                    savedVideoEngagementIds.insert(handpickedDynamicId)
                    BivvyNetworkService.shared.sendVideoEngagementLike(handpickedDynamicId: handpickedDynamicId)
                }
                let interactiveFeedDirection: CGFloat = peerInteractionTranslation.x >= 0 ? 1 : -1
                UIView.animate(withDuration: 0.18, animations: {
                    self.videoSnippetCard.transform = CGAffineTransform(translationX: interactiveFeedDirection * self.view.bounds.width, y: 0).rotated(by: interactiveFeedDirection * 0.2)
                    self.videoSnippetCard.alpha = 0.4
                }, completion: { _ in
                    self.videoSnippetCard.transform = CGAffineTransform(translationX: -interactiveFeedDirection * self.view.bounds.width * 0.32, y: 0)
                    self.advanceToNextVideoSnippet()
                    UIView.animate(withDuration: 0.18) {
                        self.videoSnippetCard.transform = .identity
                        self.videoSnippetCard.alpha = 1
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.videoSnippetCard.transform = .identity
                }
            }
        default:
            break
        }
    }
}

extension VideoDiscoveryFeedViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        !(touch.view is UIControl)
    }
}

typealias BivvyVideoViewController = VideoDiscoveryFeedViewController
