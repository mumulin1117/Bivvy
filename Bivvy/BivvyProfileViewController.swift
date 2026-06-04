import UIKit

final class BivvyProfileViewController: UIViewController {
    private let gridCollectionView: UICollectionView
    private var selectedSegmentIndex = 0
    private var segmentButtons: [UIButton] = []

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

        let avatar = UIImageView(image: UIImage(named: "bivvy_tab_profile_idlesel"))
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 43

        let editButton = UIButton(type: .system)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.tintColor = .white
        editButton.backgroundColor = .black
        editButton.layer.cornerRadius = 16

        let stats = makeStatsStack()

        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "No Name"
        nameLabel.font = BivvyAuthTheme.titleFont(size: 24)
        nameLabel.textColor = .black

        let bioLabel = UILabel()
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.text = "No signiture"
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

        view.addSubview(background)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [title, messageButton, settingsButton, avatar, editButton, stats, nameLabel, bioLabel, segments, gridCollectionView].forEach(contentView.addSubview)

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

            avatar.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            avatar.widthAnchor.constraint(equalToConstant: 86),
            avatar.heightAnchor.constraint(equalToConstant: 86),

            editButton.trailingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: -2),
            editButton.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -2),
            editButton.widthAnchor.constraint(equalToConstant: 32),
            editButton.heightAnchor.constraint(equalToConstant: 32),

            stats.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            stats.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 22),
            stats.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stats.heightAnchor.constraint(equalToConstant: 54),

            nameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: avatar.leadingAnchor),
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
            gridCollectionView.heightAnchor.constraint(equalToConstant: 610),
            gridCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
        ])
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
        [("0", "Friends"), ("0", "Followers"), ("0", "Following")].forEach {
            stack.addArrangedSubview(makeStat(value: $0.0, label: $0.1))
        }
        return stack
    }

    private func makeStat(value: String, label: String) -> UIView {
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.textAlignment = .center

        let labelView = UILabel()
        labelView.text = label
        labelView.font = .systemFont(ofSize: 13, weight: .regular)
        labelView.textColor = UIColor(red: 126 / 255, green: 126 / 255, blue: 126 / 255, alpha: 1)
        labelView.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [valueLabel, labelView])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
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
}

extension BivvyProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        BivvyMockContent.profileGrid.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BivvyProfileGridCell.reuseIdentifier, for: indexPath) as! BivvyProfileGridCell
        cell.configure(with: BivvyMockContent.profileGrid[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.bounds.width - 14) / 2)
        return CGSize(width: width, height: width * 1.05 + 46)
    }
}
