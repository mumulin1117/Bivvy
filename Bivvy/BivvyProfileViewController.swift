import UIKit

final class CommunityHubProfileViewController: UIViewController {
    private let contentCreatorGridView: UICollectionView
    private let contentCreatorAvatarView = UIImageView(image: UIImage(named: "bivvy_tab_profile_idlesel"))
    private let contentCreatorNameLabel = UILabel()
    private let authenticVoiceBioLabel = UILabel()
    private let emptyCollectionLabel = UILabel()
    private var engagementMetricLabels: [UILabel] = []
    private var contentCreatorItems: [ContentCreatorProfileItem] = []
    private var selectedContentCurationIndex = 0
    private var contentCurationButtons: [UIButton] = []
    private var contentCreatorGridHeightConstraint: NSLayoutConstraint?

    init() {
        let contentCreatorGridLayout = UICollectionViewFlowLayout()
        contentCreatorGridLayout.scrollDirection = .vertical
        contentCreatorGridLayout.minimumLineSpacing = 14
        contentCreatorGridLayout.minimumInteritemSpacing = 14
        contentCreatorGridView = UICollectionView(frame: .zero, collectionViewLayout: contentCreatorGridLayout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildCommunityHubProfileLayout()
        loadCommunityHubProfileData()
    }

    private func buildCommunityHubProfileLayout() {
        view.backgroundColor = .white

        let communityHubBackground = ProductCurationGradientView()
        communityHubBackground.translatesAutoresizingMaskIntoConstraints = false
        communityHubBackground.curatedListColors = [
            UIColor(red: 255 / 255, green: 205 / 255, blue: 215 / 255, alpha: 1),
            UIColor(red: 255 / 255, green: 246 / 255, blue: 251 / 255, alpha: 1),
            UIColor.white
        ]
        communityHubBackground.productCurationStartPoint = CGPoint(x: 0, y: 0)
        communityHubBackground.productCurationEndPoint = CGPoint(x: 0.82, y: 0.5)

        let communityHubScrollView = UIScrollView()
        communityHubScrollView.translatesAutoresizingMaskIntoConstraints = false
        communityHubScrollView.alwaysBounceVertical = true
        communityHubScrollView.showsVerticalScrollIndicator = false
        communityHubScrollView.backgroundColor = .clear

        let communityHubContentView = UIView()
        communityHubContentView.translatesAutoresizingMaskIntoConstraints = false
        communityHubContentView.backgroundColor = .clear

        let communityHubTitleLabel = UILabel()
        communityHubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        communityHubTitleLabel.text = "Profile"
        communityHubTitleLabel.font = CommunitySharingAuthTheme.dailyInspirationDisplayFont(size: 30)
        communityHubTitleLabel.textColor = .black
        communityHubTitleLabel.layer.shadowColor = UIColor.white.cgColor
        communityHubTitleLabel.layer.shadowOpacity = 1
        communityHubTitleLabel.layer.shadowRadius = 0
        communityHubTitleLabel.layer.shadowOffset = CGSize(width: 2, height: 2)

        let conversationStarterButton = makeCommunityHubIconButton(systemName: "ellipsis.message.fill")
        conversationStarterButton.addTarget(self, action: #selector(openConversationStarterMessages), for: .touchUpInside)

        let smartFilterButton = makeCommunityHubIconButton(systemName: "gearshape.fill")
        smartFilterButton.addTarget(self, action: #selector(openSmartFilterSettings), for: .touchUpInside)

        contentCreatorAvatarView.translatesAutoresizingMaskIntoConstraints = false
        contentCreatorAvatarView.contentMode = .scaleAspectFill
        contentCreatorAvatarView.clipsToBounds = true
        contentCreatorAvatarView.layer.cornerRadius = 43

        let authenticVoiceEditButton = UIButton(type: .system)
        authenticVoiceEditButton.translatesAutoresizingMaskIntoConstraints = false
        authenticVoiceEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        authenticVoiceEditButton.tintColor = .white
        authenticVoiceEditButton.backgroundColor = .black
        authenticVoiceEditButton.layer.cornerRadius = 16
        authenticVoiceEditButton.addTarget(self, action: #selector(openAuthenticVoiceEdit), for: .touchUpInside)

        let engagementMetricStack = makeEngagementMetricStack()

        contentCreatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentCreatorNameLabel.text = BivvyStringVault.noData
        contentCreatorNameLabel.font = CommunitySharingAuthTheme.productShowcaseTitleFont(size: 24)
        contentCreatorNameLabel.textColor = .black

        authenticVoiceBioLabel.translatesAutoresizingMaskIntoConstraints = false
        authenticVoiceBioLabel.text = BivvyStringVault.noData
        authenticVoiceBioLabel.font = .systemFont(ofSize: 15, weight: .regular)
        authenticVoiceBioLabel.textColor = UIColor(red: 74 / 255, green: 74 / 255, blue: 74 / 255, alpha: 1)
        authenticVoiceBioLabel.numberOfLines = 2

        let contentCurationControl = makeContentCurationControl()

        contentCreatorGridView.translatesAutoresizingMaskIntoConstraints = false
        contentCreatorGridView.backgroundColor = .clear
        contentCreatorGridView.isScrollEnabled = false
        contentCreatorGridView.dataSource = self
        contentCreatorGridView.delegate = self
        contentCreatorGridView.register(BivvyProfileGridCell.self, forCellWithReuseIdentifier: BivvyProfileGridCell.reuseIdentifier)

        emptyCollectionLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyCollectionLabel.text = BivvyStringVault.noData
        emptyCollectionLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        emptyCollectionLabel.textColor = UIColor.black.withAlphaComponent(0.46)
        emptyCollectionLabel.textAlignment = .center

        view.addSubview(communityHubBackground)
        view.addSubview(communityHubScrollView)
        communityHubScrollView.addSubview(communityHubContentView)
        [communityHubTitleLabel, conversationStarterButton, smartFilterButton, contentCreatorAvatarView, authenticVoiceEditButton, engagementMetricStack, contentCreatorNameLabel, authenticVoiceBioLabel, contentCurationControl, contentCreatorGridView, emptyCollectionLabel].forEach(communityHubContentView.addSubview)

        contentCreatorGridHeightConstraint = contentCreatorGridView.heightAnchor.constraint(equalToConstant: 96)

        NSLayoutConstraint.activate([
            communityHubBackground.topAnchor.constraint(equalTo: view.topAnchor),
            communityHubBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            communityHubBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            communityHubBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            communityHubScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            communityHubScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            communityHubScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            communityHubScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            communityHubContentView.topAnchor.constraint(equalTo: communityHubScrollView.contentLayoutGuide.topAnchor),
            communityHubContentView.leadingAnchor.constraint(equalTo: communityHubScrollView.contentLayoutGuide.leadingAnchor),
            communityHubContentView.trailingAnchor.constraint(equalTo: communityHubScrollView.contentLayoutGuide.trailingAnchor),
            communityHubContentView.bottomAnchor.constraint(equalTo: communityHubScrollView.contentLayoutGuide.bottomAnchor),
            communityHubContentView.widthAnchor.constraint(equalTo: communityHubScrollView.frameLayoutGuide.widthAnchor),

            communityHubTitleLabel.topAnchor.constraint(equalTo: communityHubContentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            communityHubTitleLabel.leadingAnchor.constraint(equalTo: communityHubContentView.leadingAnchor, constant: 24),

            smartFilterButton.centerYAnchor.constraint(equalTo: communityHubTitleLabel.centerYAnchor),
            smartFilterButton.trailingAnchor.constraint(equalTo: communityHubContentView.trailingAnchor, constant: -20),
            smartFilterButton.widthAnchor.constraint(equalToConstant: 48),
            smartFilterButton.heightAnchor.constraint(equalToConstant: 48),

            conversationStarterButton.centerYAnchor.constraint(equalTo: smartFilterButton.centerYAnchor),
            conversationStarterButton.trailingAnchor.constraint(equalTo: smartFilterButton.leadingAnchor, constant: -12),
            conversationStarterButton.widthAnchor.constraint(equalToConstant: 48),
            conversationStarterButton.heightAnchor.constraint(equalToConstant: 48),

            contentCreatorAvatarView.topAnchor.constraint(equalTo: communityHubTitleLabel.bottomAnchor, constant: 30),
            contentCreatorAvatarView.leadingAnchor.constraint(equalTo: communityHubContentView.leadingAnchor, constant: 28),
            contentCreatorAvatarView.widthAnchor.constraint(equalToConstant: 86),
            contentCreatorAvatarView.heightAnchor.constraint(equalToConstant: 86),

            authenticVoiceEditButton.trailingAnchor.constraint(equalTo: contentCreatorAvatarView.trailingAnchor, constant: -2),
            authenticVoiceEditButton.bottomAnchor.constraint(equalTo: contentCreatorAvatarView.bottomAnchor, constant: -2),
            authenticVoiceEditButton.widthAnchor.constraint(equalToConstant: 32),
            authenticVoiceEditButton.heightAnchor.constraint(equalToConstant: 32),

            engagementMetricStack.centerYAnchor.constraint(equalTo: contentCreatorAvatarView.centerYAnchor),
            engagementMetricStack.leadingAnchor.constraint(equalTo: contentCreatorAvatarView.trailingAnchor, constant: 22),
            engagementMetricStack.trailingAnchor.constraint(equalTo: communityHubContentView.trailingAnchor, constant: -20),
            engagementMetricStack.heightAnchor.constraint(equalToConstant: 54),

            contentCreatorNameLabel.topAnchor.constraint(equalTo: contentCreatorAvatarView.bottomAnchor, constant: 16),
            contentCreatorNameLabel.leadingAnchor.constraint(equalTo: contentCreatorAvatarView.leadingAnchor),
            contentCreatorNameLabel.trailingAnchor.constraint(equalTo: communityHubContentView.trailingAnchor, constant: -24),

            authenticVoiceBioLabel.topAnchor.constraint(equalTo: contentCreatorNameLabel.bottomAnchor, constant: 8),
            authenticVoiceBioLabel.leadingAnchor.constraint(equalTo: contentCreatorNameLabel.leadingAnchor),
            authenticVoiceBioLabel.trailingAnchor.constraint(equalTo: communityHubContentView.trailingAnchor, constant: -24),

            contentCurationControl.topAnchor.constraint(equalTo: authenticVoiceBioLabel.bottomAnchor, constant: 24),
            contentCurationControl.leadingAnchor.constraint(equalTo: communityHubContentView.leadingAnchor, constant: 24),
            contentCurationControl.trailingAnchor.constraint(equalTo: communityHubContentView.trailingAnchor, constant: -24),
            contentCurationControl.heightAnchor.constraint(equalToConstant: 58),

            contentCreatorGridView.topAnchor.constraint(equalTo: contentCurationControl.bottomAnchor, constant: 20),
            contentCreatorGridView.leadingAnchor.constraint(equalTo: communityHubContentView.leadingAnchor, constant: 24),
            contentCreatorGridView.trailingAnchor.constraint(equalTo: communityHubContentView.trailingAnchor, constant: -24),
            contentCreatorGridHeightConstraint!,
            contentCreatorGridView.bottomAnchor.constraint(equalTo: communityHubContentView.bottomAnchor, constant: -28),

            emptyCollectionLabel.topAnchor.constraint(equalTo: contentCurationControl.bottomAnchor, constant: 36),
            emptyCollectionLabel.leadingAnchor.constraint(equalTo: communityHubContentView.leadingAnchor, constant: 24),
            emptyCollectionLabel.trailingAnchor.constraint(equalTo: communityHubContentView.trailingAnchor, constant: -24)
        ])
        updateContentCreatorGridHeight()
    }

    private func makeCommunityHubIconButton(systemName: String) -> UIButton {
        let communityHubButton = UIButton(type: .system)
        communityHubButton.translatesAutoresizingMaskIntoConstraints = false
        communityHubButton.backgroundColor = UIColor(red: 255 / 255, green: 222 / 255, blue: 250 / 255, alpha: 1)
        communityHubButton.tintColor = .black
        communityHubButton.layer.cornerRadius = 24
        communityHubButton.setImage(UIImage(systemName: systemName), for: .normal)
        communityHubButton.imageView?.contentMode = .scaleAspectFit
        return communityHubButton
    }

    private func makeEngagementMetricStack() -> UIStackView {
        let engagementMetricStack = UIStackView()
        engagementMetricStack.translatesAutoresizingMaskIntoConstraints = false
        engagementMetricStack.axis = .horizontal
        engagementMetricStack.distribution = .fillEqually
        engagementMetricStack.spacing = 8
        engagementMetricLabels.removeAll()
        [("0", "Friends"), ("0", "Followers"), ("0", "Following")].enumerated().forEach { metricIndex, metricItem in
            engagementMetricStack.addArrangedSubview(makeEngagementMetricView(value: metricItem.0, label: metricItem.1, tag: metricIndex + 1))
        }
        return engagementMetricStack
    }

    private func makeEngagementMetricView(value: String, label: String, tag: Int) -> UIView {
        let engagementMetricValueLabel = UILabel()
        engagementMetricValueLabel.text = value
        engagementMetricValueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        engagementMetricValueLabel.textColor = .black
        engagementMetricValueLabel.textAlignment = .center
        engagementMetricLabels.append(engagementMetricValueLabel)

        let engagementMetricNameLabel = UILabel()
        engagementMetricNameLabel.text = label
        engagementMetricNameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        engagementMetricNameLabel.textColor = UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)
        engagementMetricNameLabel.textAlignment = .center

        let peerInteractionStack = UIStackView(arrangedSubviews: [engagementMetricValueLabel, engagementMetricNameLabel])
        peerInteractionStack.axis = .vertical
        peerInteractionStack.spacing = 4
        peerInteractionStack.alignment = .center
        peerInteractionStack.tag = tag
        peerInteractionStack.isUserInteractionEnabled = true
        peerInteractionStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openInterestGroupList(_:))))
        return peerInteractionStack
    }

    private func makeContentCurationControl() -> UIView {
        let contentCurationContainer = UIView()
        contentCurationContainer.translatesAutoresizingMaskIntoConstraints = false
        contentCurationContainer.backgroundColor = UIColor(red: 253 / 255, green: 218 / 255, blue: 242 / 255, alpha: 1)
        contentCurationContainer.layer.cornerRadius = 24
        contentCurationContainer.layer.masksToBounds = true

        let contentCurationStack = UIStackView()
        contentCurationStack.translatesAutoresizingMaskIntoConstraints = false
        contentCurationStack.axis = .horizontal
        contentCurationStack.distribution = .fillEqually
        contentCurationStack.spacing = 0

        ["Post", "Video"].enumerated().forEach { contentCurationIndex, contentCurationTitle in
            let contentCurationButton = UIButton(type: .system)
            contentCurationButton.tag = contentCurationIndex
            contentCurationButton.setTitle(contentCurationTitle, for: .normal)
            contentCurationButton.titleLabel?.font = CommunitySharingAuthTheme.sharingMechanicButtonFont(size: 18)
            contentCurationButton.layer.cornerRadius = 22
            contentCurationButton.addTarget(self, action: #selector(selectContentCuration(_:)), for: .touchUpInside)
            contentCurationButtons.append(contentCurationButton)
            contentCurationStack.addArrangedSubview(contentCurationButton)
        }

        contentCurationContainer.addSubview(contentCurationStack)
        NSLayoutConstraint.activate([
            contentCurationStack.topAnchor.constraint(equalTo: contentCurationContainer.topAnchor, constant: 4),
            contentCurationStack.leadingAnchor.constraint(equalTo: contentCurationContainer.leadingAnchor, constant: 4),
            contentCurationStack.trailingAnchor.constraint(equalTo: contentCurationContainer.trailingAnchor, constant: -4),
            contentCurationStack.bottomAnchor.constraint(equalTo: contentCurationContainer.bottomAnchor, constant: -4)
        ])
        updateContentCurationButtons()
        return contentCurationContainer
    }

    private func updateContentCurationButtons() {
        for contentCurationButton in contentCurationButtons {
            let isContentCurationSelected = contentCurationButton.tag == selectedContentCurationIndex
            contentCurationButton.backgroundColor = isContentCurationSelected ? UIColor(red: 241 / 255, green: 82 / 255, blue: 227 / 255, alpha: 1) : .clear
            contentCurationButton.setTitleColor(isContentCurationSelected ? .white : UIColor(red: 178 / 255, green: 151 / 255, blue: 172 / 255, alpha: 1), for: .normal)
        }
    }

    @objc private func selectContentCuration(_ sender: UIButton) {
        selectedContentCurationIndex = sender.tag
        updateContentCurationButtons()
        contentCreatorGridView.reloadData()
    }

    @objc private func openConversationStarterMessages() {
        let conversationStarterPage = BivvyMessageViewController()
        conversationStarterPage.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(conversationStarterPage, animated: true)
    }

    @objc private func openSmartFilterSettings() {
        openCommunityHubWebRoute(.smartFilter)
    }

    @objc private func openAuthenticVoiceEdit() {
        openCommunityHubWebRoute(.authenticVoice)
    }

    @objc private func openInterestGroupList(_ gesture: UITapGestureRecognizer) {
        guard let interestGroupType = gesture.view?.tag else { return }
        
        openCommunityHubWebRoute(.interestGroup(type: "\(interestGroupType)"))
    }

    private func openCommunityHubWebRoute(_ route: BivvyH5Route) {
        guard let communityHubURL = route.productCurationURL() else { return }
        let communityHubWebPage = BivvyWebViewController(url: communityHubURL)
        communityHubWebPage.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(communityHubWebPage, animated: true)
    }

    private func loadCommunityHubProfileData() {
        BivvyNetworkService.shared.fetchCommunityHubProfile { [weak self] result in
            guard let self else { return }
            if case .success(let profile) = result {
                self.contentCreatorNameLabel.text = profile.contentCreatorName.isEmpty ? BivvyStringVault.noData : profile.contentCreatorName
                self.authenticVoiceBioLabel.text = profile.authenticVoiceAbout.isEmpty ? BivvyStringVault.noData : profile.authenticVoiceAbout
                BivvyRemoteImageLoader.shared.load(profile.contentCreatorAvatarURL, into: self.contentCreatorAvatarView, placeholder: UIImage(named: "bivvy_tab_profile_idlesel"))
                let engagementMetrics = [profile.peerInteractionFriendsCount, profile.communityInteractionFollowersCount, profile.interestMatchingFollowingCount]
                for (metricIndex, metricValue) in engagementMetrics.enumerated() where self.engagementMetricLabels.indices.contains(metricIndex) {
                    self.engagementMetricLabels[metricIndex].text = metricValue
                }
            }
        }

        BivvyNetworkService.shared.fetchContentCreatorCollection { [weak self] result in
            guard let self else { return }
            if case .success(let items) = result {
                self.contentCreatorItems = items
                self.contentCreatorGridView.reloadData()
                self.updateContentCreatorGridHeight()
            }
        }
    }

    private func updateContentCreatorGridHeight() {
        let communityHubAvailableWidth = max(0, view.bounds.width - 48)
        let contentCreatorItemWidth = floor((communityHubAvailableWidth - 14) / 2)
        let contentCreatorRows = max(1, Int(ceil(Double(contentCreatorItems.count) / 2.0)))
        emptyCollectionLabel.isHidden = !contentCreatorItems.isEmpty
        contentCreatorGridView.isHidden = contentCreatorItems.isEmpty
        contentCreatorGridHeightConstraint?.constant = contentCreatorItems.isEmpty ? 96 : CGFloat(contentCreatorRows) * (contentCreatorItemWidth * 1.05 + 46) + CGFloat(max(0, contentCreatorRows - 1)) * 14
    }
}

extension CommunityHubProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentCreatorItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contentCreatorCell = collectionView.dequeueReusableCell(withReuseIdentifier: BivvyProfileGridCell.reuseIdentifier, for: indexPath) as! BivvyProfileGridCell
        contentCreatorCell.configure(with: contentCreatorItems[indexPath.item])
        return contentCreatorCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentCreatorWidth = floor((collectionView.bounds.width - 14) / 2)
        return CGSize(width: contentCreatorWidth, height: contentCreatorWidth * 1.05 + 46)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let handpickedDynamicId = contentCreatorItems[indexPath.item].handpickedDynamicId,
              let videoSnippetURL = BivvyH5Route.videoSnippet(handpickedDynamicId: handpickedDynamicId).productCurationURL() else { return }
        let videoSnippetWebPage = BivvyWebViewController(url: videoSnippetURL)
        videoSnippetWebPage.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(videoSnippetWebPage, animated: true)
    }
}

typealias BivvyProfileViewController = CommunityHubProfileViewController
