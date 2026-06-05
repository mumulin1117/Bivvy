import UIKit

final class ProductShowcaseDetailViewController: UIViewController {
    private let productShowcaseItem: ProductShowcaseFindItem
    private var userRecommendation: UserRecommendationProfile?
    private let savedItemButton = UIButton()
    private var productWalkthroughDotViews: [UIView] = []
    private var productWalkthroughDotWidthConstraints: [NSLayoutConstraint] = []
    private var productWalkthroughImageNames: [String] {
        let productWalkthroughNames = productShowcaseItem.productWalkthroughImageNames?.filter { UIImage.bivvyFindImage(namedOrPath: $0) != nil } ?? []
        return productWalkthroughNames.isEmpty ? [productShowcaseItem.productShowcaseImageName] : productWalkthroughNames
    }

    init(productShowcaseItem: ProductShowcaseFindItem, userRecommendation: UserRecommendationProfile?) {
        self.productShowcaseItem = productShowcaseItem
        self.userRecommendation = userRecommendation
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildProductShowcaseDetailLayout()
        loadBoundUserRecommendationIfNeeded()
    }

    private func buildProductShowcaseDetailLayout() {
        view.backgroundColor = .white

        let productShowcaseScrollView = UIScrollView()
        productShowcaseScrollView.translatesAutoresizingMaskIntoConstraints = false
        productShowcaseScrollView.alwaysBounceVertical = true
        productShowcaseScrollView.showsVerticalScrollIndicator = false
        productShowcaseScrollView.contentInsetAdjustmentBehavior = .never

        let productShowcaseContentView = UIView()
        productShowcaseContentView.translatesAutoresizingMaskIntoConstraints = false

        let productWalkthroughScrollView = makeProductWalkthroughCarousel()

        let productWalkthroughDimView = ProductCurationGradientView()
        productWalkthroughDimView.translatesAutoresizingMaskIntoConstraints = false
        productWalkthroughDimView.isUserInteractionEnabled = false
        productWalkthroughDimView.curatedListColors = [
            UIColor.black.withAlphaComponent(0.08),
            UIColor.black.withAlphaComponent(0.36)
        ]

        let communityHubBackButton = UIButton(type: .system)
        communityHubBackButton.translatesAutoresizingMaskIntoConstraints = false
        communityHubBackButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        communityHubBackButton.tintColor = .white
        communityHubBackButton.addTarget(self, action: #selector(closeProductShowcaseDetail), for: .touchUpInside)

        let trustedReviewReportButton = UIButton(type: .system)
        trustedReviewReportButton.translatesAutoresizingMaskIntoConstraints = false
        trustedReviewReportButton.setImage(UIImage(systemName: "flag.fill"), for: .normal)
        trustedReviewReportButton.tintColor = CommunitySharingAuthTheme.favoriteFindPink
        trustedReviewReportButton.backgroundColor = UIColor.white.withAlphaComponent(0.92)
        trustedReviewReportButton.layer.cornerRadius = 18
        trustedReviewReportButton.imageView?.contentMode = .scaleAspectFit
        trustedReviewReportButton.addTarget(self, action: #selector(openTrustedReviewReport), for: .touchUpInside)

        let productWalkthroughDots = makeProductWalkthroughDots(count: productWalkthroughImageNames.count)
        let productShowcaseDetailCard = makeProductShowcaseDetailCard()
       
        configureSavedItemActionButton()
        
        let peerInteractionContactButton = SharingMechanicGradientButton(title: BivvyStringVault.contactHer)
        peerInteractionContactButton.translatesAutoresizingMaskIntoConstraints = false
        peerInteractionContactButton.isEnabled = true
        peerInteractionContactButton.addTarget(self, action: #selector(openBoundUserRecommendation), for: .touchUpInside)

        view.addSubview(productShowcaseScrollView)
        productShowcaseScrollView.addSubview(productShowcaseContentView)
        productShowcaseContentView.addSubview(productWalkthroughScrollView)
        productShowcaseContentView.addSubview(productWalkthroughDimView)
        productShowcaseContentView.addSubview(productWalkthroughDots)
        productShowcaseContentView.addSubview(productShowcaseDetailCard)
        view.addSubview(communityHubBackButton)
        view.addSubview(trustedReviewReportButton)
        view.addSubview(savedItemButton)
        view.addSubview(peerInteractionContactButton)

        NSLayoutConstraint.activate([
            productShowcaseScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            productShowcaseScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productShowcaseScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productShowcaseScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            productShowcaseContentView.topAnchor.constraint(equalTo: productShowcaseScrollView.contentLayoutGuide.topAnchor),
            productShowcaseContentView.leadingAnchor.constraint(equalTo: productShowcaseScrollView.contentLayoutGuide.leadingAnchor),
            productShowcaseContentView.trailingAnchor.constraint(equalTo: productShowcaseScrollView.contentLayoutGuide.trailingAnchor),
            productShowcaseContentView.bottomAnchor.constraint(equalTo: productShowcaseScrollView.contentLayoutGuide.bottomAnchor),
            productShowcaseContentView.widthAnchor.constraint(equalTo: productShowcaseScrollView.frameLayoutGuide.widthAnchor),

            productWalkthroughScrollView.topAnchor.constraint(equalTo: productShowcaseContentView.topAnchor),
            productWalkthroughScrollView.leadingAnchor.constraint(equalTo: productShowcaseContentView.leadingAnchor),
            productWalkthroughScrollView.trailingAnchor.constraint(equalTo: productShowcaseContentView.trailingAnchor),
            productWalkthroughScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.41),

            productWalkthroughDimView.topAnchor.constraint(equalTo: productWalkthroughScrollView.topAnchor),
            productWalkthroughDimView.leadingAnchor.constraint(equalTo: productWalkthroughScrollView.leadingAnchor),
            productWalkthroughDimView.trailingAnchor.constraint(equalTo: productWalkthroughScrollView.trailingAnchor),
            productWalkthroughDimView.bottomAnchor.constraint(equalTo: productWalkthroughScrollView.bottomAnchor),

            communityHubBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:19),
            communityHubBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            communityHubBackButton.widthAnchor.constraint(equalToConstant: 36),
            communityHubBackButton.heightAnchor.constraint(equalToConstant: 36),

            trustedReviewReportButton.centerYAnchor.constraint(equalTo: communityHubBackButton.centerYAnchor),
            trustedReviewReportButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            trustedReviewReportButton.widthAnchor.constraint(equalToConstant: 36),
            trustedReviewReportButton.heightAnchor.constraint(equalToConstant: 36),

            productWalkthroughDots.leadingAnchor.constraint(equalTo: productShowcaseContentView.leadingAnchor, constant: 40),
            productWalkthroughDots.bottomAnchor.constraint(equalTo: productWalkthroughScrollView.bottomAnchor, constant: -58),
            productWalkthroughDots.heightAnchor.constraint(equalToConstant: 12),

            productShowcaseDetailCard.topAnchor.constraint(equalTo: productWalkthroughScrollView.bottomAnchor, constant: 40),
            productShowcaseDetailCard.leadingAnchor.constraint(equalTo: productShowcaseContentView.leadingAnchor, constant: 24),
            productShowcaseDetailCard.trailingAnchor.constraint(equalTo: productShowcaseContentView.trailingAnchor, constant: -24),
            productShowcaseDetailCard.bottomAnchor.constraint(equalTo: productShowcaseContentView.bottomAnchor, constant: -128),

            savedItemButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            savedItemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            savedItemButton.widthAnchor.constraint(equalToConstant: 52),
            savedItemButton.heightAnchor.constraint(equalToConstant: 52),

            peerInteractionContactButton.leadingAnchor.constraint(equalTo: savedItemButton.trailingAnchor, constant: 20),
            peerInteractionContactButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            peerInteractionContactButton.centerYAnchor.constraint(equalTo: savedItemButton.centerYAnchor),
            peerInteractionContactButton.heightAnchor.constraint(equalToConstant: 66)
        ])
    }

    private func makeProductWalkthroughCarousel() -> UIScrollView {
        let productWalkthroughScrollView = UIScrollView()
        productWalkthroughScrollView.translatesAutoresizingMaskIntoConstraints = false
        productWalkthroughScrollView.isPagingEnabled = true
        productWalkthroughScrollView.contentInsetAdjustmentBehavior = .never
        productWalkthroughScrollView.showsHorizontalScrollIndicator = false
        productWalkthroughScrollView.bounces = productWalkthroughImageNames.count > 1
        productWalkthroughScrollView.clipsToBounds = true
        productWalkthroughScrollView.delegate = self

        let productWalkthroughStack = UIStackView()
        productWalkthroughStack.translatesAutoresizingMaskIntoConstraints = false
        productWalkthroughStack.axis = .horizontal
        productWalkthroughStack.spacing = 0

        productWalkthroughScrollView.addSubview(productWalkthroughStack)
        NSLayoutConstraint.activate([
            productWalkthroughStack.topAnchor.constraint(equalTo: productWalkthroughScrollView.contentLayoutGuide.topAnchor),
            productWalkthroughStack.leadingAnchor.constraint(equalTo: productWalkthroughScrollView.contentLayoutGuide.leadingAnchor),
            productWalkthroughStack.trailingAnchor.constraint(equalTo: productWalkthroughScrollView.contentLayoutGuide.trailingAnchor),
            productWalkthroughStack.bottomAnchor.constraint(equalTo: productWalkthroughScrollView.contentLayoutGuide.bottomAnchor),
            productWalkthroughStack.heightAnchor.constraint(equalTo: productWalkthroughScrollView.frameLayoutGuide.heightAnchor)
        ])

        for productWalkthroughImageName in productWalkthroughImageNames {
            let productWalkthroughImageView = UIImageView(image: UIImage.bivvyFindImage(namedOrPath: productWalkthroughImageName))
            productWalkthroughImageView.translatesAutoresizingMaskIntoConstraints = false
            productWalkthroughImageView.contentMode = .scaleAspectFill
            productWalkthroughImageView.clipsToBounds = true
            productWalkthroughStack.addArrangedSubview(productWalkthroughImageView)
            productWalkthroughImageView.widthAnchor.constraint(equalTo: productWalkthroughScrollView.frameLayoutGuide.widthAnchor).isActive = true
        }
        return productWalkthroughScrollView
    }

    private func makeProductShowcaseDetailCard() -> UIView {
        let productShowcaseCard = UIView()
        productShowcaseCard.translatesAutoresizingMaskIntoConstraints = false
        productShowcaseCard.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        productShowcaseCard.layer.cornerRadius = 24
        productShowcaseCard.layer.masksToBounds = true

        let detailedReviewStack = UIStackView()
        detailedReviewStack.translatesAutoresizingMaskIntoConstraints = false
        detailedReviewStack.axis = .vertical
        detailedReviewStack.spacing = 26

        detailedReviewStack.addArrangedSubview(makeDetailedReviewBlock(productHighlightTitle: BivvyStringVault.productName, value: productShowcaseItem.productHighlightTitle))
        detailedReviewStack.addArrangedSubview(makeDetailedReviewBlock(productHighlightTitle: BivvyStringVault.qualityGrade, value: productShowcaseItem.excellentConditionGrade ?? BivvyStringVault.fallbackQuality))
        detailedReviewStack.addArrangedSubview(makeDetailedReviewBlock(productHighlightTitle: BivvyStringVault.commodityPrices, value: productShowcaseItem.communityMarketPrice ?? BivvyStringVault.fallbackPrice))
        detailedReviewStack.addArrangedSubview(makeDetailedReviewBlock(productHighlightTitle: BivvyStringVault.city, value: productShowcaseItem.communityMarketCity ?? BivvyStringVault.fallbackCity))
        detailedReviewStack.addArrangedSubview(makeDetailedReviewBlock(productHighlightTitle: BivvyStringVault.exchangeDemands, value: productShowcaseItem.itemExchangeDemand ?? productShowcaseItem.detailedReviewText))

        productShowcaseCard.addSubview(detailedReviewStack)
        NSLayoutConstraint.activate([
            detailedReviewStack.topAnchor.constraint(equalTo: productShowcaseCard.topAnchor, constant: 42),
            detailedReviewStack.leadingAnchor.constraint(equalTo: productShowcaseCard.leadingAnchor, constant: 25),
            detailedReviewStack.trailingAnchor.constraint(equalTo: productShowcaseCard.trailingAnchor, constant: -25),
            detailedReviewStack.bottomAnchor.constraint(equalTo: productShowcaseCard.bottomAnchor, constant: -42)
        ])
        return productShowcaseCard
    }

    private func makeDetailedReviewBlock(productHighlightTitle: String, value: String) -> UIView {
        let productHighlightTitleLabel = UILabel()
        productHighlightTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        productHighlightTitleLabel.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        productHighlightTitleLabel.text = productHighlightTitle

        let detailedReviewValueLabel = UILabel()
        detailedReviewValueLabel.font = .systemFont(ofSize: 20, weight: .regular)
        detailedReviewValueLabel.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        detailedReviewValueLabel.numberOfLines = 0
        detailedReviewValueLabel.text = value

        let productDiscussionStack = UIStackView(arrangedSubviews: [productHighlightTitleLabel, detailedReviewValueLabel])
        productDiscussionStack.axis = .vertical
        productDiscussionStack.spacing = 12
        return productDiscussionStack
    }

    private func makeProductWalkthroughDots(count: Int) -> UIStackView {
        let productWalkthroughDotStack = UIStackView()
        productWalkthroughDotStack.translatesAutoresizingMaskIntoConstraints = false
        productWalkthroughDotStack.axis = .horizontal
        productWalkthroughDotStack.spacing = 8
        productWalkthroughDotViews.removeAll()
        productWalkthroughDotWidthConstraints.removeAll()
        for dotIndex in 0..<max(1, count) {
            let productWalkthroughDot = UIView()
            productWalkthroughDot.translatesAutoresizingMaskIntoConstraints = false
            productWalkthroughDot.backgroundColor = dotIndex == 0 ? .white : UIColor.white.withAlphaComponent(0.45)
            productWalkthroughDot.layer.cornerRadius = 5
            let productWalkthroughWidthConstraint = productWalkthroughDot.widthAnchor.constraint(equalToConstant: dotIndex == 0 ? 80 : 12)
            productWalkthroughWidthConstraint.isActive = true
            productWalkthroughDot.heightAnchor.constraint(equalToConstant: 10).isActive = true
            productWalkthroughDotStack.addArrangedSubview(productWalkthroughDot)
            productWalkthroughDotViews.append(productWalkthroughDot)
            productWalkthroughDotWidthConstraints.append(productWalkthroughWidthConstraint)
        }
        return productWalkthroughDotStack
    }

    private func updateProductWalkthroughDots(currentPage: Int) {
        for (dotIndex, productWalkthroughDot) in productWalkthroughDotViews.enumerated() {
            productWalkthroughDot.backgroundColor = dotIndex == currentPage ? .white : UIColor.white.withAlphaComponent(0.45)
            productWalkthroughDotWidthConstraints[dotIndex].constant = dotIndex == currentPage ? 80 : 12
        }
        UIView.animate(withDuration: 0.18) {
            self.productWalkthroughDotViews.first?.superview?.layoutIfNeeded()
        }
    }

    private func configureSavedItemActionButton() {
        savedItemButton.translatesAutoresizingMaskIntoConstraints = false
        savedItemButton.setImage(UIImage(named: "btnDetailFUN"), for: .normal)
        savedItemButton.setImage(UIImage(named: "btnDetailman"), for: .selected)
        savedItemButton.addTarget(self, action: #selector(toggleSavedItem), for: .touchUpInside)
        updateSavedItemVisual(animated: false)
    }

    @objc private func closeProductShowcaseDetail() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func openTrustedReviewReport() {
        guard let trustedReviewURL = BivvyH5Route.trustedReview(handpickedDynamicId: productShowcaseItem.productShowcaseId).productCurationURL() else { return }
        let trustedReviewWebPage = BivvyWebViewController(url: trustedReviewURL)
        trustedReviewWebPage.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(trustedReviewWebPage, animated: true)
    }

    @objc private func toggleSavedItem() {
        let isSavedItem = BivvyLocalFindStore.communityMarket.toggleSavedItem(productShowcaseId: productShowcaseItem.productShowcaseId)
        updateSavedItemVisual(animated: true)
        let feedbackGenerator = UIImpactFeedbackGenerator(style: isSavedItem ? .medium : .light)
        feedbackGenerator.impactOccurred()
    }

    private func updateSavedItemVisual(animated: Bool) {
        let isSavedItem = BivvyLocalFindStore.communityMarket.isSavedItem(productShowcaseId: productShowcaseItem.productShowcaseId)
        savedItemButton.isSelected = isSavedItem
        if animated {
            savedItemButton.alpha = 1
            UIView.animate(withDuration: 0.12) {
                self.savedItemButton.transform = CGAffineTransform(scaleX: 1.12, y: 1.12)
            } completion: { _ in
                UIView.animate(withDuration: 0.16) {
                    self.savedItemButton.transform = .identity
                    self.savedItemButton.alpha = isSavedItem ? 1 : 0.92
                }
            }
        } else {
            savedItemButton.transform = .identity
            savedItemButton.alpha = isSavedItem ? 1 : 0.92
        }
    }

    private func loadBoundUserRecommendationIfNeeded() {
        guard userRecommendation == nil else { return }
        BivvyNetworkService.shared.fetchUserRecommendationProfiles { [weak self] result in
            guard let self else { return }
            if case .success(let userRecommendations) = result {
                self.userRecommendation = self.boundUserRecommendation(from: userRecommendations)
            }
        }
    }

    private func boundUserRecommendation(from userRecommendations: [UserRecommendationProfile]) -> UserRecommendationProfile? {
        guard !userRecommendations.isEmpty else { return nil }
        let productShowcaseItems = BivvyLocalFindStore.communityMarket.productShowcaseItems
        let productShowcaseIndex = productShowcaseItems.firstIndex { $0.productShowcaseId == productShowcaseItem.productShowcaseId } ?? 0
        return userRecommendations[productShowcaseIndex % userRecommendations.count]
    }

    @objc private func openBoundUserRecommendation() {
        guard let userRecommendation,
              let userDiscoveryURL = BivvyH5Route.userDiscovery(userDiscoveryId: userRecommendation.productShowcaseId).productCurationURL() else {
            let alert = UIAlertController(title: BivvyStringVault.userLoading, message: BivvyStringVault.waitUsers, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: BivvyStringVault.ok, style: .default))
            present(alert, animated: true)
            return
        }
        let userDiscoveryPage = BivvyWebViewController(url: userDiscoveryURL)
        userDiscoveryPage.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(userDiscoveryPage, animated: true)
    }
}

extension ProductShowcaseDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isPagingEnabled, scrollView.bounds.width > 0 else { return }
        let productWalkthroughPage = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        let boundedProductWalkthroughPage = max(0, min(productWalkthroughDotViews.count - 1, productWalkthroughPage))
        updateProductWalkthroughDots(currentPage: boundedProductWalkthroughPage)
    }
}

typealias BivvyFindDetailViewController = ProductShowcaseDetailViewController
