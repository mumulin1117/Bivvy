import UIKit

final class CommunityHubMainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCommunityHubTabAppearance()
        setViewControllers(makeCommunityHubControllers(), animated: false)
    }

    private func makeCommunityHubControllers() -> [UIViewController] {
        [
            makeProductShowcaseNavigation(root: BivvyHomeViewController(), productHighlightTitle: "Home", productShowcaseIconName: "bivvy_tab_hoome_idle"),
            makeProductShowcaseNavigation(root: BivvyVideoViewController(), productHighlightTitle: "Video", productShowcaseIconName: "bivvy_tab_vv_idle"),
            makeProductShowcaseNavigation(root: BivvyProfileViewController(), productHighlightTitle: "Mine", productShowcaseIconName: "bivvy_tab_profile_idle")
        ]
    }

    private func makeProductShowcaseNavigation(root: UIViewController, productHighlightTitle: String, productShowcaseIconName: String) -> UINavigationController {
        let communityHubNavigation = UINavigationController(rootViewController: root)
        communityHubNavigation.setNavigationBarHidden(true, animated: false)
        let itemCollectionIcon = UIImage(named: productShowcaseIconName)?.withRenderingMode(.alwaysOriginal)
        let savedItemIcon = UIImage(named: productShowcaseIconName + "sel")?.withRenderingMode(.alwaysOriginal)
        
        communityHubNavigation.tabBarItem = UITabBarItem(title: productHighlightTitle, image: itemCollectionIcon, selectedImage: savedItemIcon)
        return communityHubNavigation
    }

    private func configureCommunityHubTabAppearance() {
        let usefulFindInactiveColor = UIColor.lightGray
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = usefulFindInactiveColor
        tabBar.itemPositioning = .fill
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.08
        tabBar.layer.shadowRadius = 18
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -6)

        let communityHubAppearance = UITabBarAppearance()
        communityHubAppearance.configureWithOpaqueBackground()
        communityHubAppearance.backgroundColor = UIColor.white
        communityHubAppearance.shadowColor = .clear

        let everydayDiscoveryText = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .semibold),
            NSAttributedString.Key.foregroundColor: usefulFindInactiveColor
        ]
        let savedItemText = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        [communityHubAppearance.stackedLayoutAppearance, communityHubAppearance.inlineLayoutAppearance, communityHubAppearance.compactInlineLayoutAppearance].forEach {
            $0.normal.iconColor = usefulFindInactiveColor
            $0.normal.titleTextAttributes = everydayDiscoveryText
            
            $0.selected.titleTextAttributes = savedItemText
        }

        tabBar.standardAppearance = communityHubAppearance
        tabBar.scrollEdgeAppearance = communityHubAppearance
    }
}

typealias BivvyMainTabBarController = CommunityHubMainTabBarController
