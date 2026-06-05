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
        let selIcon = UIImage(named: iconName + "sel")?.withRenderingMode(.alwaysOriginal)
        
        nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selIcon)
        return nav
    }

    private func configureAppearance() {
        let inactiveColor = UIColor.lightGray
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = inactiveColor
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
            NSAttributedString.Key.foregroundColor: inactiveColor
        ]
        let selectedText = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        [appearance.stackedLayoutAppearance, appearance.inlineLayoutAppearance, appearance.compactInlineLayoutAppearance].forEach {
            $0.normal.iconColor = inactiveColor
            $0.normal.titleTextAttributes = normalText
            
            $0.selected.titleTextAttributes = selectedText
        }

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
