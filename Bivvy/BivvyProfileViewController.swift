import UIKit

final class BivvyProfileViewController: UIViewController {
    private let gridCollectionView: UICollectionView
    private let avatarView = UIImageView(image: UIImage(named: "bivvy_tab_profile_idlesel"))
    private let nameLabel = UILabel()
    private let bioLabel = UILabel()
    private let gridEmptyLabel = UILabel()
    private var statValueLabels: [UILabel] = []
    private var gridItems: [BivvyProfileItem] = []
    private var selectedSegmentIndex = 0
    private var segmentButtons: [UIButton] = []
    private var gridCollectionHeightConstraint: NSLayoutConstraint?

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 14
        gridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        loadProfileData()
    }

    private func buildLayout() {
        view.backgroundColor = .white

        let background = BivvyGradientView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.colors = [
            UIColor(red: 255 / 255, green: 205 / 255, blue: 215 / 255, alpha: 1),
            UIColor(red: 255 / 255, green: 246 / 255, blue: 251 / 255, alpha: 1),
            UIColor.white
        ]
        background.startPoint = CGPoint(x: 0, y: 0)
        background.endPoint = CGPoint(x: 0.82, y: 0.5)

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear

        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Profile"
        title.font = BivvyAuthTheme.displayFont(size: 30)
        title.textColor = .black
        title.layer.shadowColor = UIColor.white.cgColor
        title.layer.shadowOpacity = 1
        title.layer.shadowRadius = 0
        title.layer.shadowOffset = CGSize(width: 2, height: 2)

        let messageButton = makeCircleIconButton(systemName: "ellipsis.message.fill")
        messageButton.addTarget(self, action: #selector(openMessages), for: .touchUpInside)

        let settingsButton = makeCircleIconButton(systemName: "gearshape.fill")
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)

        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.contentMode = .scaleAspectFill
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 43

        let editButton = UIButton(type: .system)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.tintColor = .white
        editButton.backgroundColor = .black
        editButton.layer.cornerRadius = 16
        editButton.addTarget(self, action: #selector(openEditProfile), for: .touchUpInside)

        let stats = makeStatsStack()

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "No data available."
        nameLabel.font = BivvyAuthTheme.titleFont(size: 24)
        nameLabel.textColor = .black

        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.text = "No data available."
        bioLabel.font = .systemFont(ofSize: 15, weight: .regular)
        bioLabel.textColor = UIColor(red: 74 / 255, green: 74 / 255, blue: 74 / 255, alpha: 1)
        bioLabel.numberOfLines = 2

        let segments = makeSegmentControl()

        gridCollectionView.translatesAutoresizingMaskIntoConstraints = false
        gridCollectionView.backgroundColor = .clear
        gridCollectionView.isScrollEnabled = false
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
        gridCollectionView.register(BivvyProfileGridCell.self, forCellWithReuseIdentifier: BivvyProfileGridCell.reuseIdentifier)

        gridEmptyLabel.translatesAutoresizingMaskIntoConstraints = false
        gridEmptyLabel.text = "No data available."
        gridEmptyLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        gridEmptyLabel.textColor = UIColor.black.withAlphaComponent(0.46)
        gridEmptyLabel.textAlignment = .center

        view.addSubview(background)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [title, messageButton, settingsButton, avatarView, editButton, stats, nameLabel, bioLabel, segments, gridCollectionView, gridEmptyLabel].forEach(contentView.addSubview)

        gridCollectionHeightConstraint = gridCollectionView.heightAnchor.constraint(equalToConstant: 96)

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            title.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),

            settingsButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            settingsButton.widthAnchor.constraint(equalToConstant: 48),
            settingsButton.heightAnchor.constraint(equalToConstant: 48),

            messageButton.centerYAnchor.constraint(equalTo: settingsButton.centerYAnchor),
            messageButton.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -12),
            messageButton.widthAnchor.constraint(equalToConstant: 48),
            messageButton.heightAnchor.constraint(equalToConstant: 48),

            avatarView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            avatarView.widthAnchor.constraint(equalToConstant: 86),
            avatarView.heightAnchor.constraint(equalToConstant: 86),

            editButton.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: -2),
            editButton.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: -2),
            editButton.widthAnchor.constraint(equalToConstant: 32),
            editButton.heightAnchor.constraint(equalToConstant: 32),

            stats.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            stats.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 22),
            stats.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stats.heightAnchor.constraint(equalToConstant: 54),

            nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            bioLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            segments.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 24),
            segments.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            segments.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            segments.heightAnchor.constraint(equalToConstant: 58),

            gridCollectionView.topAnchor.constraint(equalTo: segments.bottomAnchor, constant: 20),
            gridCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            gridCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            gridCollectionHeightConstraint!,
            gridCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),

            gridEmptyLabel.topAnchor.constraint(equalTo: segments.bottomAnchor, constant: 36),
            gridEmptyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            gridEmptyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
        updateGridHeight()
    }

    private func makeCircleIconButton(systemName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255 / 255, green: 222 / 255, blue: 250 / 255, alpha: 1)
        button.tintColor = .black
        button.layer.cornerRadius = 24
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }

    private func makeStatsStack() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        statValueLabels.removeAll()
        [("0", "Friends"), ("0", "Followers"), ("0", "Following")].enumerated().forEach { index, item in
            stack.addArrangedSubview(makeStat(value: item.0, label: item.1, tag: index))
        }
        return stack
    }

    private func makeStat(value: String, label: String, tag: Int) -> UIView {
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.textAlignment = .center
        statValueLabels.append(valueLabel)

        let labelView = UILabel()
        labelView.text = label
        labelView.font = .systemFont(ofSize: 13, weight: .regular)
        labelView.textColor = UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)
        labelView.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [valueLabel, labelView])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.tag = tag
        stack.isUserInteractionEnabled = true
        stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openFollowList(_:))))
        return stack
    }

    private func makeSegmentControl() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(red: 253 / 255, green: 218 / 255, blue: 242 / 255, alpha: 1)
        container.layer.cornerRadius = 24
        container.layer.masksToBounds = true

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0

        ["Post", "Video"].enumerated().forEach { index, title in
            let button = UIButton(type: .system)
            button.tag = index
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = BivvyAuthTheme.buttonFont(size: 18)
            button.layer.cornerRadius = 22
            button.addTarget(self, action: #selector(selectSegment(_:)), for: .touchUpInside)
            segmentButtons.append(button)
            stack.addArrangedSubview(button)
        }

        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 4),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -4)
        ])
        updateSegments()
        return container
    }

    private func updateSegments() {
        for button in segmentButtons {
            let selected = button.tag == selectedSegmentIndex
            button.backgroundColor = selected ? UIColor(red: 241 / 255, green: 82 / 255, blue: 227 / 255, alpha: 1) : .clear
            button.setTitleColor(selected ? .white : UIColor(red: 178 / 255, green: 151 / 255, blue: 172 / 255, alpha: 1), for: .normal)
        }
    }

    @objc private func selectSegment(_ sender: UIButton) {
        selectedSegmentIndex = sender.tag
        updateSegments()
        gridCollectionView.reloadData()
    }

    @objc private func openMessages() {
        let message = BivvyMessageViewController()
        message.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(message, animated: true)
    }

    @objc private func openSettings() {
        openWebRoute(.settings)
    }

    @objc private func openEditProfile() {
        openWebRoute(.editProfile)
    }

    @objc private func openFollowList(_ gesture: UITapGestureRecognizer) {
        guard let tag = gesture.view?.tag else { return }
        
        openWebRoute(.followList(type: "\(tag)"))
    }

    private func openWebRoute(_ route: BivvyH5Route) {
        guard let url = route.url() else { return }
        let web = BivvyWebViewController(url: url)
        web.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(web, animated: true)
    }

    private func loadProfileData() {
        BivvyNetworkService.shared.fetchProfile { [weak self] result in
            guard let self else { return }
            if case .success(let profile) = result {
                self.nameLabel.text = profile.name.isEmpty ? "No data available." : profile.name
                self.bioLabel.text = profile.about.isEmpty ? "No data available." : profile.about
                BivvyRemoteImageLoader.shared.load(profile.avatarURL, into: self.avatarView, placeholder: UIImage(named: "bivvy_tab_profile_idlesel"))
                let values = [profile.friendsCount, profile.followersCount, profile.followingCount]
                for (index, value) in values.enumerated() where self.statValueLabels.indices.contains(index) {
                    self.statValueLabels[index].text = value
                }
            }
        }

        BivvyNetworkService.shared.fetchMyContent { [weak self] result in
            guard let self else { return }
            if case .success(let items) = result {
                self.gridItems = items
                self.gridCollectionView.reloadData()
                self.updateGridHeight()
            }
        }
    }

    private func updateGridHeight() {
        let availableWidth = max(0, view.bounds.width - 48)
        let itemWidth = floor((availableWidth - 14) / 2)
        let rows = max(1, Int(ceil(Double(gridItems.count) / 2.0)))
        gridEmptyLabel.isHidden = !gridItems.isEmpty
        gridCollectionView.isHidden = gridItems.isEmpty
        gridCollectionHeightConstraint?.constant = gridItems.isEmpty ? 96 : CGFloat(rows) * (itemWidth * 1.05 + 46) + CGFloat(max(0, rows - 1)) * 14
    }
}

extension BivvyProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gridItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BivvyProfileGridCell.reuseIdentifier, for: indexPath) as! BivvyProfileGridCell
        cell.configure(with: gridItems[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.bounds.width - 14) / 2)
        return CGSize(width: width, height: width * 1.05 + 46)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dynamicId = gridItems[indexPath.item].dynamicId,
              let url = BivvyH5Route.videoDetail(dynamicId: dynamicId).url() else { return }
        let web = BivvyWebViewController(url: url)
        web.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(web, animated: true)
    }
}
