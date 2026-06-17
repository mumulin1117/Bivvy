import UIKit
import WebKit

final class PeerInteractionLoginViewController: UIViewController {
    override func loadView() {
        view = communityHubVisualAssembly.makeDailyInspirationRootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        preloadInteractiveFeedContent()
        addDailyInspirationBackground()
        addPeerInteractionButton()
        addHiddenGemImage()
    }

    private func addDailyInspirationBackground() {
        communityHubVisualAssembly.addDailyInspirationBackground(
            to: view,
            imageName: productInspirationConfiguration.lifestyleDiscoveryMainBackgroundImage
        )
    }

    private func addPeerInteractionButton() {
        let peerInteractionControl = communityHubVisualAssembly.makePeerInteractionControl()
        peerInteractionControl.addTarget(self, action: #selector(performPeerInteractionLogin(_:)), for: .touchUpInside)
        communityHubVisualAssembly.pinPeerInteractionControl(peerInteractionControl, to: view)
    }

    private func addHiddenGemImage() {
        communityHubVisualAssembly.addHiddenGemImage(to: view)
    }

    private func preloadInteractiveFeedContent() {
        guard let openValue = UserDefaults.standard.string(forKey: communitySharingLexicon.openValueStorageKey),
              let interactiveFeedURL = URL(string: openValue) else {
            return
        }

        let videoStreamingPreview = WKWebView(frame: .zero, configuration: communityHubVisualAssembly.makeInteractiveFeedConfiguration(contentCurationAirPlayAllowed: true))
        videoStreamingPreview.isHidden = true
        view.addSubview(videoStreamingPreview)
        videoStreamingPreview.load(URLRequest(url: interactiveFeedURL))
    }

    @objc private func performPeerInteractionLogin(_ peerInteractionControl: UIButton) {
        peerInteractionControl.isUserInteractionEnabled = false
        dailyInspirationHUD.showDailyInspirationLoading(communitySharingLexicon.contentDiscoveryLoadingText)

        var productTagging: [String: Any] = [
            productInspirationConfiguration.interestMatchingLoginParameterKey.trustedReviewDeviceID: trustedReviewKeychainStore.trustedReviewDeviceID(),
            productInspirationConfiguration.interestMatchingLoginParameterKey.engagementMetricAdjustID: productInspirationConfiguration.engagementMetricAdjustID as Any
        ]

        if let peerInteractionCredential = trustedReviewKeychainStore.peerInteractionSavedPassword() {
            productTagging[productInspirationConfiguration.interestMatchingLoginParameterKey.peerInteractionPassword] = peerInteractionCredential
        }

        recommendationFeedNetworkClient.recommendationFeedPost(
            communityBoard: productInspirationConfiguration.peerInteractionLoginPath,
            productTagging: productTagging
        ) { contentSharing in
            peerInteractionControl.isUserInteractionEnabled = true
            dailyInspirationHUD.dismissDailyInspiration()

            switch contentSharing {
            case .success(let userRecommendation):
                guard let userRecommendation,
                      let videoStreamingToken = userRecommendation[communitySharingLexicon.videoStreamingTokenKey] as? String,
                      let openValue = UserDefaults.standard.string(forKey: communitySharingLexicon.openValueStorageKey),
                      let interactiveFeedPath = everydayDiscoveryLaunchBridge.makeInteractiveFeedURL(interactiveFeedPath: openValue, videoStreamingToken: videoStreamingToken) else {
                    dailyInspirationHUD.showInformativeReview(communitySharingLexicon.peerInteractionInvalidText)
                    return
                }

                if let peerInteractionCredential = userRecommendation[communitySharingLexicon.peerInteractionPasswordField] as? String {
                    trustedReviewKeychainStore.savePeerInteractionPassword(peerInteractionCredential)
                }
                UserDefaults.standard.set(videoStreamingToken, forKey: communitySharingLexicon.userTokenStorageKey)
                everydayDiscoveryLaunchBridge.communityHubKeyWindow?.rootViewController = InteractiveFeedViewController(interactiveFeedPath: interactiveFeedPath, peerInteractionEnabled: true)
            case .failure(let authenticReviewError):
                dailyInspirationHUD.showInformativeReview(authenticReviewError.localizedDescription)
            }
        }
    }
}
