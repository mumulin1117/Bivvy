import UIKit

final class BivvyFindDetailViewController: UIViewController {
    private let item: BivvyFindItem
    private var pageDotViews: [UIView] = []
    private var pageDotWidthConstraints: [NSLayoutConstraint] = []
    private var carouselImageNames: [String] {
        let names = item.detailImageNames?.filter { UIImage(named: $0) != nil } ?? []
        return names.isEmpty ? [item.imageName] : names
    }

    init(item: BivvyFindItem) {
        self.item = item
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

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let imageScrollView = makeImageCarousel()

        let dimView = BivvyGradientView()
        dimView.translatesAutoresizingMaskIntoConstraints = false
        dimView.isUserInteractionEnabled = false
        dimView.colors = [
            UIColor.black.withAlphaComponent(0.08),
            UIColor.black.withAlphaComponent(0.36)
        ]

        let backButton = UIButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)

        let reportButton = UIButton(type: .system)
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        reportButton.setTitle("Report", for: .normal)
        reportButton.setTitleColor(BivvyAuthTheme.hotPink, for: .normal)
        reportButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        reportButton.backgroundColor = UIColor.white.withAlphaComponent(0.92)
        reportButton.layer.cornerRadius = 18
        reportButton.addTarget(self, action: #selector(openReport), for: .touchUpInside)

        let pageDots = makePageDots(count: carouselImageNames.count)
        let detailCard = makeDetailCard()
       
        let outlineHeart = makeRoundActionButton()
        
        let contactButton = BivvyGradientButton(title: "Contact her")
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactButton.isEnabled = true

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageScrollView)
        contentView.addSubview(dimView)
        contentView.addSubview(pageDots)
        contentView.addSubview(detailCard)
        view.addSubview(backButton)
        view.addSubview(reportButton)
        view.addSubview(outlineHeart)
        view.addSubview(contactButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            imageScrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.41),

            dimView.topAnchor.constraint(equalTo: imageScrollView.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: imageScrollView.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor),

            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:19),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 36),
            backButton.heightAnchor.constraint(equalToConstant: 36),

            reportButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            reportButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reportButton.widthAnchor.constraint(equalToConstant: 82),
            reportButton.heightAnchor.constraint(equalToConstant: 36),

            pageDots.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            pageDots.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: -58),
            pageDots.heightAnchor.constraint(equalToConstant: 12),

            detailCard.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 40),
            detailCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            detailCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            detailCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -128),

            outlineHeart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            outlineHeart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            outlineHeart.widthAnchor.constraint(equalToConstant: 52),
            outlineHeart.heightAnchor.constraint(equalToConstant: 52),

            contactButton.leadingAnchor.constraint(equalTo: outlineHeart.trailingAnchor, constant: 20),
            contactButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            contactButton.centerYAnchor.constraint(equalTo: outlineHeart.centerYAnchor),
            contactButton.heightAnchor.constraint(equalToConstant: 66)
        ])
    }

    private func makeImageCarousel() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = carouselImageNames.count > 1
        scrollView.clipsToBounds = true
        scrollView.delegate = self

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 0

        scrollView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stack.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])

        for imageName in carouselImageNames {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stack.addArrangedSubview(imageView)
            imageView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        }
        return scrollView
    }

    private func makeDetailCard() -> UIView {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        card.layer.cornerRadius = 24
        card.layer.masksToBounds = true

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 26

        stack.addArrangedSubview(makeInfoBlock(title: "Product Name", value: item.title))
        stack.addArrangedSubview(makeInfoBlock(title: "Quality grade", value: item.qualityGrade ?? "90% new. Minor signs of use."))
        stack.addArrangedSubview(makeInfoBlock(title: "Commodity prices", value: item.price ?? "$399"))
        stack.addArrangedSubview(makeInfoBlock(title: "City", value: item.city ?? "Los Angeles (LA)"))
        stack.addArrangedSubview(makeInfoBlock(title: "Exchange of demands", value: item.exchangeDemand ?? item.detail))

        card.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 42),
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 25),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -25),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -42)
        ])
        return card
    }

    private func makeInfoBlock(title: String, value: String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        titleLabel.text = title

        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 20, weight: .regular)
        valueLabel.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
        valueLabel.numberOfLines = 0
        valueLabel.text = value

        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.axis = .vertical
        stack.spacing = 12
        return stack
    }

    private func makePageDots(count: Int) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        pageDotViews.removeAll()
        pageDotWidthConstraints.removeAll()
        for index in 0..<max(1, count) {
            let dot = UIView()
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.backgroundColor = index == 0 ? .white : UIColor.white.withAlphaComponent(0.45)
            dot.layer.cornerRadius = 5
            let widthConstraint = dot.widthAnchor.constraint(equalToConstant: index == 0 ? 80 : 12)
            widthConstraint.isActive = true
            dot.heightAnchor.constraint(equalToConstant: 10).isActive = true
            stack.addArrangedSubview(dot)
            pageDotViews.append(dot)
            pageDotWidthConstraints.append(widthConstraint)
        }
        return stack
    }

    private func updatePageDots(currentPage: Int) {
        for (index, dot) in pageDotViews.enumerated() {
            dot.backgroundColor = index == currentPage ? .white : UIColor.white.withAlphaComponent(0.45)
            pageDotWidthConstraints[index].constant = index == currentPage ? 80 : 12
        }
        UIView.animate(withDuration: 0.18) {
            self.pageDotViews.first?.superview?.layoutIfNeeded()
        }
    }

    private func makeRoundActionButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btnDetailFUN"), for: .normal)
        button.setImage(UIImage(named: "btnDetailman"), for: .selected)
        return button
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func openReport() {
        guard let url = BivvyH5Route.report(dynamicId: item.id).url() else { return }
        let web = BivvyWebViewController(url: url)
        web.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(web, animated: true)
    }
}

extension BivvyFindDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isPagingEnabled, scrollView.bounds.width > 0 else { return }
        let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        let boundedPage = max(0, min(pageDotViews.count - 1, page))
        updatePageDots(currentPage: boundedPage)
    }
}
