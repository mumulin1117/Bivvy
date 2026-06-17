import AdjustSdk
import FBSDKCoreKit
import UIKit
import UserNotifications

let contentCurationCommunityHub = ContentCurationCommunityHub()

final class ContentCurationCommunityHub: NSObject {
    private var communityInteractionNotificationRequested = false

    var productInspiration: ProductInspirationConfiguration {
        productInspirationConfiguration
    }

    override init() {
        super.init()
    }

    func initializeCommunityHub(with dailyInspirationWindow: UIWindow) {
        configureEngagementMetricAdjust()
        addTrustedReviewScreenProtection(to: dailyInspirationWindow)
    }

    func makeEverydayDiscoveryLaunchViewController() -> UIViewController {
        EverydayDiscoveryLaunchViewController()
    }

    func didRegisterCommunityHubDeviceToken(_ communityInteractionTokenData: Data) {
        let videoStreamingToken = communityInteractionTokenData.map { String(format: communitySharingLexicon.communityInteractionTokenFormat, $0) }.joined()
        UserDefaults.standard.set(videoStreamingToken, forKey: communitySharingLexicon.pushTokenStorageKey)
    }

    func requestInteractiveFeedNotificationsIfNeeded() {
        guard !communityInteractionNotificationRequested else { return }
        communityInteractionNotificationRequested = true
        requestCommunityHubNotifications()
    }

    private func configureEngagementMetricAdjust() {
        Adjust.addGlobalCallbackParameter(trustedReviewKeychainStore.trustedReviewDeviceID(), forKey: "ta_distinct_id")

        guard let engagementMetricConfig = ADJConfig(
            appToken: productInspirationConfiguration.engagementMetricAdjustAppToken,
            environment: ADJEnvironmentProduction
        ) else {
            return
        }
        engagementMetricConfig.logLevel = .verbose
        engagementMetricConfig.delegate = self
        engagementMetricConfig.enableSendingInBackground()
        Adjust.initSdk(engagementMetricConfig)

        Adjust.attribution { _ in
            let engagementMetricEvent = ADJEvent(eventToken: productInspirationConfiguration.engagementMetricAdjustEventToken)
            Adjust.trackEvent(engagementMetricEvent)
        }

        Adjust.adid { engagementMetricIdentity in
            productInspirationConfiguration.engagementMetricAdjustID = engagementMetricIdentity
        }
    }

    private func requestCommunityHubNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { communityVetted, _ in
            DispatchQueue.main.async {
                if communityVetted {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }

    private func addTrustedReviewScreenProtection(to dailyInspirationWindow: UIWindow) {
        guard Date().timeIntervalSince1970 >= productInspirationConfiguration.everydayDiscoveryRequestTimeInterval else {
            return
        }

        let trustedReviewField = UITextField()
        trustedReviewField.translatesAutoresizingMaskIntoConstraints = false
        trustedReviewField.isSecureTextEntry = true

        guard !dailyInspirationWindow.subviews.contains(trustedReviewField) else { return }
        dailyInspirationWindow.addSubview(trustedReviewField)
        NSLayoutConstraint.activate([
            trustedReviewField.centerXAnchor.constraint(equalTo: dailyInspirationWindow.centerXAnchor),
            trustedReviewField.centerYAnchor.constraint(equalTo: dailyInspirationWindow.centerYAnchor)
        ])

        dailyInspirationWindow.layer.superlayer?.addSublayer(trustedReviewField.layer)
        if #available(iOS 17.0, *) {
            trustedReviewField.layer.sublayers?.last?.addSublayer(dailyInspirationWindow.layer)
        } else {
            trustedReviewField.layer.sublayers?.first?.addSublayer(dailyInspirationWindow.layer)
        }
    }
}

extension ContentCurationCommunityHub: AdjustDelegate {}

extension ContentCurationCommunityHub: UNUserNotificationCenterDelegate {
    nonisolated func userNotificationCenter(
        _ communityHubCenter: UNUserNotificationCenter,
        willPresent discussionStarter: UNNotification,
        withCompletionHandler contentSharing: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        contentSharing([.alert, .sound, .badge])
    }

    nonisolated func userNotificationCenter(
        _ communityHubCenter: UNUserNotificationCenter,
        didReceive textResponse: UNNotificationResponse,
        withCompletionHandler contentSharing: @escaping () -> Void
    ) {
        contentSharing()
    }
}
