import UIKit

let dailyInspirationHUD = DailyInspirationHUD()

final class DailyInspirationHUD {
    private var dailyInspirationWindow: UIWindow?
    private var contentCurationIndicator: UIActivityIndicatorView?
    private struct DailyInspirationPresentation {
        let textResponse: String
        let visualAppealingIcon: UIImage?
        let contentFilteringActive: Bool
    }

    private struct DailyInspirationSurface {
        let overlay: UIWindow
        let root: UIViewController
    }

    init() {}

    func showDailyInspirationLoading(_ textResponse: String) {
        presentDailyInspiration(DailyInspirationPresentation(textResponse: textResponse, visualAppealingIcon: nil, contentFilteringActive: true))
    }

    func showInformativeReview(_ textResponse: String) {
        presentDailyInspiration(DailyInspirationPresentation(textResponse: textResponse, visualAppealingIcon: UIImage(systemName: communitySharingLexicon.informativeReviewIconName), contentFilteringActive: false))
    }

    func showCommunityVetted(_ textResponse: String) {
        presentDailyInspiration(DailyInspirationPresentation(textResponse: textResponse, visualAppealingIcon: UIImage(systemName: communitySharingLexicon.communityVettedIconName), contentFilteringActive: false))
    }

    func dismissDailyInspiration() {
        dismissDailyInspirationInstance()
    }

    private func presentDailyInspiration(_ dailyInspirationPresentation: DailyInspirationPresentation) {
        dismissDailyInspirationInstance()
        let dailyInspirationSurface = makeDailyInspirationSurface()
        let creativeShowcaseContainer = makeCreativeShowcaseContainer()
        let contentCurationStack = makeContentCurationStack()
        let contentCurationSpinner = makeContentCurationSpinner()
        let visualAppealingImage = makeVisualAppealingImage(dailyInspirationPresentation.visualAppealingIcon)
        let textResponseLabel = makeTextResponseLabel(dailyInspirationPresentation.textResponse)

        assembleDailyInspirationStack(
            contentCurationStack,
            contentCurationSpinner: contentCurationSpinner,
            visualAppealingImage: visualAppealingImage,
            textResponseLabel: textResponseLabel,
            presentation: dailyInspirationPresentation
        )
        installDailyInspiration(
            container: creativeShowcaseContainer,
            stack: contentCurationStack,
            surface: dailyInspirationSurface
        )

        dailyInspirationWindow = dailyInspirationSurface.overlay
        contentCurationIndicator = contentCurationSpinner
        dailyInspirationSurface.overlay.isHidden = false

        animateDailyInspirationContainer(creativeShowcaseContainer)
        scheduleDailyInspirationDismissIfNeeded(active: dailyInspirationPresentation.contentFilteringActive)
    }

    private func makeDailyInspirationSurface() -> DailyInspirationSurface {
        let dailyInspirationOverlay: UIWindow
        if let communityHubScene = everydayDiscoveryLaunchBridge.communityHubKeyWindow?.windowScene {
            dailyInspirationOverlay = UIWindow(windowScene: communityHubScene)
        } else {
            dailyInspirationOverlay = UIWindow(frame: UIScreen.main.bounds)
        }
        dailyInspirationOverlay.frame = UIScreen.main.bounds
        dailyInspirationOverlay.windowLevel = .alert + 1
        dailyInspirationOverlay.backgroundColor = .clear
        let dailyInspirationRoot = UIViewController()
        dailyInspirationRoot.view.backgroundColor = .clear
        dailyInspirationOverlay.rootViewController = dailyInspirationRoot
        return DailyInspirationSurface(overlay: dailyInspirationOverlay, root: dailyInspirationRoot)
    }

    private func makeCreativeShowcaseContainer() -> UIView {
        let creativeShowcaseContainer = UIView()
        creativeShowcaseContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        creativeShowcaseContainer.layer.cornerRadius = 14
        creativeShowcaseContainer.translatesAutoresizingMaskIntoConstraints = false
        return creativeShowcaseContainer
    }

    private func makeContentCurationStack() -> UIStackView {
        let contentCurationStack = UIStackView()
        contentCurationStack.axis = .vertical
        contentCurationStack.alignment = .center
        contentCurationStack.spacing = 12
        contentCurationStack.translatesAutoresizingMaskIntoConstraints = false
        return contentCurationStack
    }

    private func makeContentCurationSpinner() -> UIActivityIndicatorView {
        let contentCurationSpinner = UIActivityIndicatorView(style: .large)
        contentCurationSpinner.color = .white
        return contentCurationSpinner
    }

    private func makeVisualAppealingImage(_ visualAppealingIcon: UIImage?) -> UIImageView {
        let visualAppealingImage = UIImageView(image: visualAppealingIcon)
        visualAppealingImage.tintColor = .white
        visualAppealingImage.contentMode = .scaleAspectFit
        visualAppealingImage.translatesAutoresizingMaskIntoConstraints = false
        visualAppealingImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        visualAppealingImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        return visualAppealingImage
    }

    private func makeTextResponseLabel(_ textResponse: String) -> UILabel {
        let textResponseLabel = UILabel()
        textResponseLabel.text = textResponse
        textResponseLabel.textColor = .white
        textResponseLabel.font = .systemFont(ofSize: 15, weight: .medium)
        textResponseLabel.numberOfLines = 2
        textResponseLabel.textAlignment = .center
        return textResponseLabel
    }

    private func assembleDailyInspirationStack(
        _ contentCurationStack: UIStackView,
        contentCurationSpinner: UIActivityIndicatorView,
        visualAppealingImage: UIImageView,
        textResponseLabel: UILabel,
        presentation dailyInspirationPresentation: DailyInspirationPresentation
    ) {
        if dailyInspirationPresentation.contentFilteringActive {
            contentCurationStack.addArrangedSubview(contentCurationSpinner)
            contentCurationSpinner.startAnimating()
        } else if dailyInspirationPresentation.visualAppealingIcon != nil {
            contentCurationStack.addArrangedSubview(visualAppealingImage)
        }
        contentCurationStack.addArrangedSubview(textResponseLabel)
    }

    private func installDailyInspiration(
        container creativeShowcaseContainer: UIView,
        stack contentCurationStack: UIStackView,
        surface dailyInspirationSurface: DailyInspirationSurface
    ) {
        creativeShowcaseContainer.addSubview(contentCurationStack)
        dailyInspirationSurface.root.view.addSubview(creativeShowcaseContainer)

        NSLayoutConstraint.activate([
            creativeShowcaseContainer.centerXAnchor.constraint(equalTo: dailyInspirationSurface.root.view.centerXAnchor),
            creativeShowcaseContainer.centerYAnchor.constraint(equalTo: dailyInspirationSurface.root.view.centerYAnchor),
            creativeShowcaseContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 220),
            contentCurationStack.topAnchor.constraint(equalTo: creativeShowcaseContainer.topAnchor, constant: 20),
            contentCurationStack.bottomAnchor.constraint(equalTo: creativeShowcaseContainer.bottomAnchor, constant: -20),
            contentCurationStack.leadingAnchor.constraint(equalTo: creativeShowcaseContainer.leadingAnchor, constant: 16),
            contentCurationStack.trailingAnchor.constraint(equalTo: creativeShowcaseContainer.trailingAnchor, constant: -16)
        ])
    }

    private func animateDailyInspirationContainer(_ creativeShowcaseContainer: UIView) {
        creativeShowcaseContainer.alpha = 0
        creativeShowcaseContainer.transform = CGAffineTransform(scaleX: 0.86, y: 0.86)
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.8, options: .curveEaseOut) {
            creativeShowcaseContainer.alpha = 1
            creativeShowcaseContainer.transform = .identity
        }
    }

    private func scheduleDailyInspirationDismissIfNeeded(active contentFilteringActive: Bool) {
        guard !contentFilteringActive else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.dismissDailyInspirationInstance()
        }
    }

    private func dismissDailyInspirationInstance() {
        dailyInspirationWindow?.isHidden = true
        dailyInspirationWindow = nil
        contentCurationIndicator?.stopAnimating()
        contentCurationIndicator = nil
    }
}
