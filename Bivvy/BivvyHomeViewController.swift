import UIKit

final class BivvyHomeViewController: UIViewController {
    private let categoryCollectionView: UICollectionView
    private let userCollectionView: UICollectionView
    private let findCollectionView: UICollectionView
    private var allFinds: [ProductShowcaseFindItem] = []
    private var visibleFinds: [ProductShowcaseFindItem] = []
    private var recommendationUsers: [UserRecommendationProfile] = []
    private var selectedCategoryIndex = 0
    private var findCollectionHeightConstraint: NSLayoutConstraint?

    init() {
        let categoryLayout = UICollectionViewFlowLayout()
        categoryLayout.scrollDirection = .horizontal
        categoryLayout.minimumLineSpacing = 12
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout)

        let userLayout = UICollectionViewFlowLayout()
        userLayout.scrollDirection = .horizontal
        userLayout.minimumLineSpacing = 10
        userCollectionView = UICollectionView(frame: .zero, collectionViewLayout: userLayout)

        let findLayout = UICollectionViewFlowLayout()
        findLayout.scrollDirection = .vertical
        findLayout.minimumLineSpacing = 16
        findLayout.minimumInteritemSpacing = 12
        findCollectionView = UICollectionView(frame: .zero, collectionViewLayout: findLayout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadFinds()
        buildLayout()
        loadRecommendationUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFinds()
        categoryCollectionView.reloadData()
        findCollectionView.reloadData()
        updateFindCollectionHeight()
    }

    private func reloadFinds() {
        allFinds = BivvyLocalFindStore.communityMarket.productShowcaseItems
        applySelectedCategory()
    }

    private func applySelectedCategory() {
        guard BivvyMockContent.categories.indices.contains(selectedCategoryIndex) else {
            visibleFinds = allFinds
            return
        }
        let selectedTitle = BivvyMockContent.categories[selectedCategoryIndex].productHighlightTitle
        let filtered = allFinds.filter { ($0.productCategoryName ?? $0.productCategorySubtitle) == selectedTitle }
        visibleFinds = filtered.isEmpty ? allFinds : filtered
    }

    private func buildLayout() {
        view.backgroundColor = UIColor(red: 255 / 255, green: 244 / 255, blue: 250 / 255, alpha: 1)

        let backgroundImageView = UIImageView(image: UIImage(named: "bivvy_home_und"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.clipsToBounds = true
       

      
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear

      

        let postButton = makePostButton()
        postButton.addTarget(self, action: #selector(openPublish), for: .touchUpInside)

        let aiButton = makeAssistantButton()
        aiButton.addTarget(self, action: #selector(openAssistant), for: .touchUpInside)

        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(BivvyCategoryChipCell.self, forCellWithReuseIdentifier: BivvyCategoryChipCell.reuseIdentifier)

        userCollectionView.translatesAutoresizingMaskIntoConstraints = false
        userCollectionView.backgroundColor = .clear
        userCollectionView.showsHorizontalScrollIndicator = false
        userCollectionView.dataSource = self
        userCollectionView.delegate = self
        userCollectionView.register(BivvyHomeUserCell.self, forCellWithReuseIdentifier: BivvyHomeUserCell.reuseIdentifier)

        findCollectionView.translatesAutoresizingMaskIntoConstraints = false
        findCollectionView.backgroundColor = .clear
        findCollectionView.isScrollEnabled = false
        findCollectionView.dataSource = self
        findCollectionView.delegate = self
        findCollectionView.register(BivvyHomeFindCell.self, forCellWithReuseIdentifier: BivvyHomeFindCell.reuseIdentifier)

       
     
        view.addSubview(backgroundImageView)
       
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [postButton, aiButton,userCollectionView, categoryCollectionView,  findCollectionView].forEach(contentView.addSubview)

        findCollectionHeightConstraint = findCollectionView.heightAnchor.constraint(equalToConstant: 610)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

     
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

 
            postButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 55),
            postButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            postButton.widthAnchor.constraint(equalToConstant: 64),
            postButton.heightAnchor.constraint(equalToConstant: 67),

            aiButton.topAnchor.constraint(equalTo: postButton.bottomAnchor, constant: 38),
            aiButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
           
            aiButton.widthAnchor.constraint(equalToConstant: 90),
            aiButton.heightAnchor.constraint(equalToConstant: 90),
            userCollectionView.leadingAnchor.constraint(equalTo: aiButton.trailingAnchor, constant: 20),
            userCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            userCollectionView.heightAnchor.constraint(equalToConstant: 90),
            userCollectionView.centerYAnchor.constraint(equalTo: aiButton.centerYAnchor),
            categoryCollectionView.topAnchor.constraint(equalTo: aiButton.bottomAnchor, constant: 22),
            categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 90),

            findCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 18),
            findCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            findCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            findCollectionHeightConstraint!,
            findCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
        ])
        updateFindCollectionHeight()
    }

    private func makePostButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.setImage(UIImage.init(named: "makePostButton"), for: .normal)
        
        return button
    }

    private func makeAssistantButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
      
        button.setImage(UIImage(named: "recopal"), for: .normal)
      
        return button
    }

    private func makeSectionTitle(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = CommunitySharingAuthTheme.productShowcaseTitleFont(size: 28)
        label.textColor = .black
        return label
    }

    private func updateFindCollectionHeight() {
        let rows = max(1, Int(ceil(Double(visibleFinds.count) / 2.0)))
        let availableWidth = max(0, (view.bounds.width > 0 ? view.bounds.width : UIScreen.main.bounds.width) - 32)
        let itemWidth = floor((availableWidth - 12) / 2)
        let itemHeight = findItemHeight(for: itemWidth)
        findCollectionHeightConstraint?.constant = CGFloat(rows) * itemHeight + CGFloat(max(0, rows - 1)) * 16
    }

    private func findItemHeight(for itemWidth: CGFloat) -> CGFloat {
        max(196, itemWidth * 1.24)
    }

    private func loadRecommendationUsers() {
        BivvyNetworkService.shared.fetchUserRecommendationProfiles { [weak self] result in
            guard let self else { return }
            if case .success(let users) = result, !users.isEmpty {
                self.recommendationUsers = users
                self.userCollectionView.reloadData()
            }
        }
    }
}

extension BivvyHomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === categoryCollectionView {
            return BivvyMockContent.categories.count
        }
        if collectionView === userCollectionView {
            return recommendationUsers.count
        }
        return visibleFinds.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BivvyCategoryChipCell.reuseIdentifier, for: indexPath) as! BivvyCategoryChipCell
            cell.configure(with: BivvyMockContent.categories[indexPath.item], selected: indexPath.item == selectedCategoryIndex)
            return cell
        }
        if collectionView === userCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BivvyHomeUserCell.reuseIdentifier, for: indexPath) as! BivvyHomeUserCell
            cell.configure(with: recommendationUsers[indexPath.item])
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BivvyHomeFindCell.reuseIdentifier, for: indexPath) as! BivvyHomeFindCell
        let item = visibleFinds[indexPath.item]
        cell.configure(with: item)
        cell.trustedReviewReportAction = { [weak self] in
            self?.openFindReport(itemId: item.productShowcaseId)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === categoryCollectionView {
            let title = BivvyMockContent.categories[indexPath.item].productHighlightTitle
            let width = max(104, min(142, title.size(withAttributes: [.font: UIFont.systemFont(ofSize: 15, weight: .semibold)]).width + 34))
            return CGSize(width: width, height: 48)
        }
        if collectionView === userCollectionView {
            return CGSize(width: 90, height: 90)
        }

        let width = floor((collectionView.bounds.width - 12) / 2)
        return CGSize(width: width, height: findItemHeight(for: width))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === categoryCollectionView {
            selectedCategoryIndex = indexPath.item
            applySelectedCategory()
            categoryCollectionView.reloadData()
            findCollectionView.reloadData()
            updateFindCollectionHeight()
            return
        }
        if collectionView === findCollectionView {
            let productShowcaseItem = visibleFinds[indexPath.item]
            pushSecondary(BivvyFindDetailViewController(productShowcaseItem: productShowcaseItem, userRecommendation: userRecommendation(for: productShowcaseItem)))
        } else if collectionView === userCollectionView {
            openUserWeb(userDiscoveryId: recommendationUsers[indexPath.item].productShowcaseId)
        }
    }

    @objc private func openPublish() {
        pushSecondary(BivvyFindPublishViewController())
    }

    @objc private func openAssistant() {
        guard let url = BivvyH5Route.recommendationEngine.productCurationURL() else { return }
        pushSecondary(BivvyWebViewController(url: url))
    }

    private func openUserWeb(userDiscoveryId: String) {
        guard let url = BivvyH5Route.userDiscovery(userDiscoveryId: userDiscoveryId).productCurationURL() else { return }
        pushSecondary(BivvyWebViewController(url: url))
    }

    private func openFindReport(itemId: String) {
        guard let url = BivvyH5Route.trustedReview(handpickedDynamicId: itemId).productCurationURL() else { return }
        pushSecondary(BivvyWebViewController(url: url))
    }

    private func userRecommendation(for productShowcaseItem: ProductShowcaseFindItem) -> UserRecommendationProfile? {
        guard !recommendationUsers.isEmpty else { return nil }
        let sourceIndex = allFinds.firstIndex { $0.productShowcaseId == productShowcaseItem.productShowcaseId } ?? 0
        return recommendationUsers[sourceIndex % recommendationUsers.count]
    }

    private func pushSecondary(_ viewController: UIViewController) {
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
