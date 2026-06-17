import UIKit

final class BivvySceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = productInspirationConfiguration.dailyInspirationFallbackColor
        self.window = window
        productInspirationConfiguration.communityFindNativeRootHandler = { [weak self] _ in
            self?.showCommunityFindNativeRootWithoutAnimation()
        }
        contentCurationCommunityHub.initializeCommunityHub(with: window)
        window.rootViewController = contentCurationCommunityHub.makeEverydayDiscoveryLaunchViewController()
        window.makeKeyAndVisible()
    }

    func showMainInterface() {
        UIView.transition(with: window ?? UIWindow(), duration: 0.28, options: .transitionCrossDissolve) {
            self.window?.rootViewController = CommunityHubMainTabBarController()
        }
    }

    func showAuthInterface() {
        UIView.transition(with: window ?? UIWindow(), duration: 0.28, options: .transitionCrossDissolve) {
            self.window?.rootViewController = self.makeAuthController()
        }
    }

    private func makeAuthController() -> UIViewController {
        UINavigationController(rootViewController: BivvyAuthEntryViewController())
    }

    private func showCommunityFindNativeRootWithoutAnimation() {
        window?.rootViewController = CommunitySharingAuthStore.communityHub.personalizedFeedIsLoggedIn ? CommunityHubMainTabBarController() : makeAuthController()
    }
}
