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
        window.rootViewController = BivvyMockAuthStore.shared.isLoggedIn ? BivvyMainTabBarController() : makeAuthController()
        self.window = window
        window.makeKeyAndVisible()
    }

    func showMainInterface() {
        UIView.transition(with: window ?? UIWindow(), duration: 0.28, options: .transitionCrossDissolve) {
            self.window?.rootViewController = BivvyMainTabBarController()
        }
    }

    private func makeAuthController() -> UIViewController {
        UINavigationController(rootViewController: BivvyAuthEntryViewController())
    }
}
