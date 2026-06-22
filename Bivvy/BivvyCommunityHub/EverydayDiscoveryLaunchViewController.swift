import Network
import UIKit

let everydayDiscoveryLaunchBridge = EverydayDiscoveryLaunchBridge()

final class EverydayDiscoveryLaunchBridge {
    var communityHubKeyWindow: UIWindow? {
        let communityHubWindowLookup: () -> UIWindow? = {
            if #available(iOS 15.0, *) {
                return UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .flatMap(\.windows)
                    .first(where: \.isKeyWindow)
            }
            return UIApplication.shared.windows.first(where: \.isKeyWindow)
        }
        return communityHubWindowLookup()
    }

    func makeInteractiveFeedURL(interactiveFeedPath: String, videoStreamingToken: String) -> String? {
        func makeProductTagging() -> [String: Any] {
            [
                communitySharingLexicon.videoStreamingTokenKey: videoStreamingToken,
                communitySharingLexicon.contentSharingTimestampKey: "\(Int(Date().timeIntervalSince1970))"
            ]
        }

        let productTagging = makeProductTagging()
        let contentFilteringBuild: () -> String? = {
            guard let productTestingJSON = recommendationFeedNetworkClient.productReviewJSONString(productTagging: productTagging) else {
                return nil
            }
            return SmartDiscoveryCipher()?.smartDiscoveryEncrypt(productTestingJSON)
        }

        guard let contentFilteringResult = contentFilteringBuild() else {
            return nil
        }

        return [
            interactiveFeedPath,
            communitySharingLexicon.interactiveFeedOpenParamsPath,
            contentFilteringResult,
            communitySharingLexicon.communityHubAppIDQuery,
            productInspirationConfiguration.communityHubAppID
        ].joined()
    }
}

private enum EverydayDiscoveryStartRoute {
    case nativeRoot
    case immediateRequest
    case networkObserver
}

private enum EverydayDiscoveryResponseRoute {
    case nativeRoot
    case login
    case interactiveFeed(String)
}

private struct EverydayDiscoveryPayload {
    let isualAppealing: String?
    let contentSh: Int
}

final class EverydayDiscoveryLaunchViewController: UIViewController {
    private let recommendationFeedPathMonitor = NWPathMonitor()
    private var recommendationFeedRequestStarted = false

    override func loadView() {
        let dailyInspirationRootView = communityHubVisualAssembly.makeDailyInspirationRootView()
        communityHubVisualAssembly.addDailyInspirationBackground(
            to: dailyInspirationRootView,
            imageName: productInspirationConfiguration.dailyInspirationLaunchBackgroundImage
        )
        view = dailyInspirationRootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        performEverydayDiscoveryLaunch()
    }

    private func performEverydayDiscoveryLaunch() {
        runEverydayDiscoveryStartRoute(resolveEverydayDiscoveryStartRoute())
    }

    private func resolveEverydayDiscoveryStartRoute() -> EverydayDiscoveryStartRoute {
        guard Date().timeIntervalSince1970 > productInspirationConfiguration.everydayDiscoveryRequestTimeInterval else {
            return .nativeRoot
        }

        return UserDefaults.standard.bool(forKey: communitySharingLexicon.launchRequestStorageKey) ? .immediateRequest : .networkObserver
    }

    private func runEverydayDiscoveryStartRoute(_ communitySharingRoute: EverydayDiscoveryStartRoute) {
        switch communitySharingRoute {
        case .nativeRoot:
            productInspirationConfiguration.showCommunityFindNativeRoot()
        case .immediateRequest:
            performEverydayDiscoveryRequest()
        case .networkObserver:
            observeRecommendationFeedNetwork()
        }
    }

    private func observeRecommendationFeedNetwork() {
        recommendationFeedPathMonitor.pathUpdateHandler = { [weak self] recommendationFeedStatus in
            DispatchQueue.main.async {
                self?.handleRecommendationFeedNetworkStatus(recommendationFeedStatus)
            }
        }
        recommendationFeedPathMonitor.start(queue: DispatchQueue(label: communitySharingLexicon.recommendationFeedNetworkQueueName))
    }

    private func handleRecommendationFeedNetworkStatus(_ recommendationFeedStatus: NWPath) {
        switch (recommendationFeedStatus.status == .satisfied, recommendationFeedRequestStarted) {
        case (true, false):
            recommendationFeedRequestStarted = true
            dailyInspirationHUD.dismissDailyInspiration()
            performEverydayDiscoveryRequest()
            recommendationFeedPathMonitor.cancel()
        case (false, false):
            dailyInspirationHUD.showDailyInspirationLoading(communitySharingLexicon.contentDiscoveryLoadingText)
        default:
            break
        }
    }

    private func performEverydayDiscoveryRequest() {
        beginEverydayDiscoveryRequestState()

        recommendationFeedNetworkClient.recommendationFeedPost(
            communityBoard: productInspirationConfiguration.everydayDiscoveryDetailPath,
            productTagging: [communitySharingLexicon.productTestingDebugField: "1"]
        ) { contentSharing in
            self.finishEverydayDiscoveryRequest(contentSharing)
        }
    }

    private func beginEverydayDiscoveryRequestState() {
        dailyInspirationHUD.showDailyInspirationLoading(communitySharingLexicon.contentDiscoveryLoadingText)
        UserDefaults.standard.set(true, forKey: communitySharingLexicon.launchRequestStorageKey)
    }

    private func finishEverydayDiscoveryRequest(_ contentSharing: Result<[String: Any]?, Error>) {
        dailyInspirationHUD.dismissDailyInspiration()
        runEverydayDiscoveryResponseRoute(resolveEverydayDiscoveryResponseRoute(contentSharing))
    }

    private func resolveEverydayDiscoveryResponseRoute(_ contentSharing: Result<[String: Any]?, Error>) -> EverydayDiscoveryResponseRoute {
        switch contentSharing {
        case .success(let userRecommendation):
            guard let userRecommendation,
                  let dailyInspirationPayload = makeEverydayDiscoveryPayload(from: userRecommendation) else {
                return .nativeRoot
            }
            return routeEverydayDiscoveryPayload(dailyInspirationPayload)
        case .failure:
            return .nativeRoot
        }
    }

    private func makeEverydayDiscoveryPayload(from userRecommendation: [String: Any]) -> EverydayDiscoveryPayload? {
        let isualAppealing = userRecommendation[communitySharingLexicon.interactiveFeedOpenValueField] as? String
        let contentSh = userRecommendation[communitySharingLexicon.peerInteractionLoginFlagField] as? Int ?? 0
        UserDefaults.standard.set(isualAppealing, forKey: communitySharingLexicon.openValueStorageKey)
        return EverydayDiscoveryPayload(isualAppealing: isualAppealing, contentSh: contentSh)
    }

    private func routeEverydayDiscoveryPayload(_ dailyInspirationPayload: EverydayDiscoveryPayload) -> EverydayDiscoveryResponseRoute {
        switch dailyInspirationPayload.contentSh {
        case 1:
            guard let videoStreamingToken = UserDefaults.standard.string(forKey: communitySharingLexicon.userTokenStorageKey),
                  let dailyFindPath = dailyInspirationPayload.isualAppealing,
                  let interactiveFeedPath = everydayDiscoveryLaunchBridge.makeInteractiveFeedURL(interactiveFeedPath: dailyFindPath, videoStreamingToken: videoStreamingToken) else {
                return .login
            }
            return .interactiveFeed(interactiveFeedPath)
        case 0:
            return .login
        default:
            return .nativeRoot
        }
    }

    private func runEverydayDiscoveryResponseRoute(_ communitySharingRoute: EverydayDiscoveryResponseRoute) {
        switch communitySharingRoute {
        case .nativeRoot:
            productInspirationConfiguration.showCommunityFindNativeRoot()
        case .login:
            everydayDiscoveryLaunchBridge.communityHubKeyWindow?.rootViewController = PeerInteractionLoginViewController()
        case .interactiveFeed(let interactiveFeedPath):
            everydayDiscoveryLaunchBridge.communityHubKeyWindow?.rootViewController = InteractiveFeedViewController(interactiveFeedPath: interactiveFeedPath, peerInteractionEnabled: false)
        }
    }
}
