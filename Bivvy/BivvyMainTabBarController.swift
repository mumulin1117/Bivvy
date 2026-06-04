import UIKit

final class BivvyMainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setViewControllers(makeControllers(), animated: false)
    }

    private func makeControllers() -> [UIViewController] {
        [
            makeNavController(root: BivvyHomeViewController(), title: "Home", iconName: "bivvy_tab_hoome_idle"),
            makeNavController(root: BivvyVideoViewController(), title: "Video", iconName: "bivvy_tab_vv_idle"),
            makeNavController(root: BivvyProfileViewController(), title: "Mine", iconName: "bivvy_tab_profile_idle")
        ]
    }

    private func makeNavController(root: UIViewController, title: String, iconName: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: root)
        nav.setNavigationBarHidden(true, animated: false)
        let image = UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal)
        let selimg =  UIImage(named: iconName  + "sel")?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selimg)
        return nav
    }

    private func configureAppearance() {
        tabBar.tintColor = BivvyAuthTheme.hotPink
        tabBar.unselectedItemTintColor = UIColor(red: 159 / 255, green: 154 / 255, blue: 166 / 255, alpha: 1)
        tabBar.itemPositioning = .fill
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.08
        tabBar.layer.shadowRadius = 18
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -6)

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = .clear

        let normalText = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor(red: 159 / 255, green: 154 / 255, blue: 166 / 255, alpha: 1)
        ]
        let selectedText = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .bold),
            NSAttributedString.Key.foregroundColor: BivvyAuthTheme.hotPink
        ]

        [appearance.stackedLayoutAppearance, appearance.inlineLayoutAppearance, appearance.compactInlineLayoutAppearance].forEach {
            $0.normal.iconColor = UIColor(red: 159 / 255, green: 154 / 255, blue: 166 / 255, alpha: 1)
            $0.normal.titleTextAttributes = normalText
            $0.selected.iconColor = BivvyAuthTheme.hotPink
            $0.selected.titleTextAttributes = selectedText
        }

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
