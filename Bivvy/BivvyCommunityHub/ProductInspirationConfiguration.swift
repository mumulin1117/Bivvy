import CommonCrypto
import UIKit
import WebKit

let productInspirationConfiguration = ProductInspirationConfiguration()

final class ProductInspirationConfiguration {
    private let productShowcaseKey: [UInt8] = [0x78, 0x36, 0x66, 0x34, 0x33, 0x71, 0x68, 0x33, 0x75, 0x61, 0x7a, 0x6c, 0x79, 0x73, 0x75, 0x30]
    private let productShowcaseVector: [UInt8] = [0x6d, 0x7a, 0x78, 0x64, 0x35, 0x30, 0x65, 0x32, 0x73, 0x78, 0x6c, 0x66, 0x37, 0x74, 0x6d, 0x79]

    init() {}

    var smartDiscoveryDebugMode: Bool = false

    var recommendationFeedReleaseBaseURL: String = "https://opi.r7jezwfk.link"
    var communityHubReleaseAppID: String = "71388066"
    var contentFilteringReleaseAESKey: String = "x6f43qh3uazlysu0"
    var contentFilteringReleaseAESIV: String = "mzxd50e2sxlf7tmy"

    var everydayDiscoveryRequestTimeInterval: TimeInterval = 0

    var engagementMetricAdjustID: String? {
        get { UserDefaults.standard.string(forKey: communitySharingLexicon.engagementMetricIDStorageKey) }
        set { UserDefaults.standard.set(newValue, forKey: communitySharingLexicon.engagementMetricIDStorageKey) }
    }

    var engagementMetricAdjustJSONResponse: String? {
        get { UserDefaults.standard.string(forKey: communitySharingLexicon.engagementMetricJSONStorageKey) }
        set { UserDefaults.standard.set(newValue, forKey: communitySharingLexicon.engagementMetricJSONStorageKey) }
    }

    var engagementMetricAdjustAppToken: String = "gojz9llwrx8g"
    var engagementMetricAdjustEventToken: String = "9pbgcm"
    var engagementMetricPurchaseToken: String = "7el5p9"

    var dailyInspirationLaunchBackgroundImage: String = "bivvyLaunch"
    var lifestyleDiscoveryMainBackgroundImage: String = "BibbyUiolaunch"
    var peerInteractionButtonBackgroundImage: String = "BibbyUiloginback"
    var hiddenGemSmallImageName: String = "BibbyUio"
    var dailyInspirationFallbackColor: UIColor = UIColor(red: 1.0, green: 0.92, blue: 0.97, alpha: 1.0)

    var peerInteractionButtonWidth: CGFloat = 351
    var peerInteractionButtonHeight: CGFloat = 52
    var peerInteractionButtonTextColor: UIColor = .clear
    var hiddenGemSmallImageWidth: CGFloat = 202
    var hiddenGemSmallImageHeight: CGFloat = 114

    var everydayDiscoveryDetailPath: String = "/opi/v1/eerInteractio"
    var peerInteractionLoginPath: String = "/opi/v1/eerInteractil"
    var engagementMetricReportTimePath: String = "/opi/v1/eerInteractit"
    var productTestingReceiptPath: String = "/opi/v1/eerInteractip"

    var interestMatchingLoginParameterKey = InterestMatchingLoginParameterKey(
        trustedReviewDeviceID: "actionButtonWin",
        engagementMetricAdjustID: "actionButtonWia",
        peerInteractionPassword: "TestingReceid"
    )

    var engagementMetricReportTimeParameterKey: String = "engagementMeo"

    var productTestingReceiptParameterKey = ProductTestingReceiptParameterKey(
        productTestingPayload: "tTestingRecep",
        productTestingTransactionID: "tTestingRecet",
        productTestingCallbackResult: "tTestingRecec"
    )

    var productShowcasePurchasePrices: [String: String] {
        smartDiscoveryDebugMode ? [
            productShowcaseAES("bb88e77ed1ec8ae06a2abd9d31134368c86c73307b755eff275dfa1a87de4f45"): productShowcaseAES("2f1316554024596e7e55f579c71f0fbe"),
            productShowcaseAES("9e52453c15629181d8a6e8e5b9cf9c8fccb3133bc7e5b973903ffde31947e9e7"): productShowcaseAES("5be88c8788bd73657dfd51d1798124a6"),
            productShowcaseAES("c7eec94e45cad1b010d48cba16a3766a9483a4d20c5820293ca1f2e27b5f2322"): productShowcaseAES("9c4ddab2a8fd6f3c959225f2d8378fe6"),
            productShowcaseAES("7225fabadb7e5222a139847c80f8d8163761ac3429d0af454b0576cdb8a87d03"): productShowcaseAES("43a75efcc4fca68c08996b216440ffc7"),
            productShowcaseAES("8c23617b8ba388ff5fdb71aa5f11b47544b24763518704e019d0feddda9a6187"): productShowcaseAES("414e188c4d01b58e92c49d604895410f"),
            productShowcaseAES("6d887482bed0a2333dda01abb20174eb6b0524c17e0954c5a2d1e8abb23a5818"): productShowcaseAES("082451fe89e6b56fbf10ec8bafe55d67")
        ] : [
            productShowcaseAES("dbbb7feea0c1bf0a20413a684a26e63359b8b9ef6aad665f9b2184686f8597e8"): productShowcaseAES("082451fe89e6b56fbf10ec8bafe55d67"),
            productShowcaseAES("74cdeb9bda8c48f4d251dff6473b355dc0437400d2894494ce328cdbf00166d2"): productShowcaseAES("414e188c4d01b58e92c49d604895410f"),
            productShowcaseAES("0367d70843519e83654782f4f774e828ac2f15ea0500093ed407239ba2a90699"): productShowcaseAES("43a75efcc4fca68c08996b216440ffc7"),
            productShowcaseAES("dc36720f2404fdc2bbc55d8171aafc05aec1d2e68e31c6c133e7956d37264596"): productShowcaseAES("9c4ddab2a8fd6f3c959225f2d8378fe6"),
            productShowcaseAES("64947e78c496371d018cfe1dd093a45901c03490d82b27c6f571ae246846e8ac"): productShowcaseAES("5be88c8788bd73657dfd51d1798124a6"),
            productShowcaseAES("bf32f1a2d70658dca1f7592f0594d50e1185188d324449e5acee9ed653c744b0"): productShowcaseAES("52497bdad6677c15671427fc143242de"),
            productShowcaseAES("cb6d6d30643a829c4675be9955c8bf49f716e0e6d23c700a1e9fc4351c76d6d9"): productShowcaseAES("2f1316554024596e7e55f579c71f0fbe"),
            productShowcaseAES("ff24fdfe44cb3df98d6da37d6f88511745a3588fd9316fbf247076e63d7a82f7"): productShowcaseAES("cac707c1364f3ca9ff3a508da117b40f"),
            productShowcaseAES("cc9ba84774f376dc6388f1a3b2f8e5121808989919490f68fec9c5cc4ec03436"): productShowcaseAES("2c364bbb732130fff4b61e5131ec4744"),
            productShowcaseAES("ede127e0d5f330dc7e8cde6d8cdbab1d43d7674e1a1463cad41d8edfde8d281b"): productShowcaseAES("f71a70ccbfc1084a193e48e6dd6edd73"),
            productShowcaseAES("24a6e315fb4e7171c10b0a169c95bf2d563d8be3b7cd846b90103ce466a78426"): productShowcaseAES("335c872b9d87eccc820a3b44ceb68bbb")
        ]
    }

    var communityFindNativeRootHandler: ((UIWindow?) -> Void)?

    func showCommunityFindNativeRoot() {
        communityFindNativeRootHandler?(everydayDiscoveryLaunchBridge.communityHubKeyWindow)
    }

    var recommendationFeedBaseURL: String {
        recommendationFeedReleaseBaseURL
    }

    var communityHubAppID: String {
        smartDiscoveryDebugMode ? "44332211" : communityHubReleaseAppID
    }

    var contentFilteringAESKey: String {
        smartDiscoveryDebugMode ? "518486he8pzgbjsk" : contentFilteringReleaseAESKey
    }

    var contentFilteringAESIV: String {
        smartDiscoveryDebugMode ? "614436p28qzhkjsl" : contentFilteringReleaseAESIV
    }

    private func productShowcaseAES(_ productHighlight: String) -> String {
        guard let contentCurationData = Data(productReviewHexString: productHighlight) else { return "" }

        let productReviewCapacity = contentCurationData.count + kCCBlockSizeAES128
        var authenticSharingData = Data(count: productReviewCapacity)
        var communityVettedLength: size_t = 0

        let sharedInterestStatus = authenticSharingData.withUnsafeMutableBytes { authenticSharingBytes in
            contentCurationData.withUnsafeBytes { contentCurationBytes in
                productShowcaseKey.withUnsafeBytes { productShowcaseBytes in
                    productShowcaseVector.withUnsafeBytes { interestMatchingBytes in
                        CCCrypt(
                            CCOperation(kCCDecrypt),
                            CCAlgorithm(kCCAlgorithmAES),
                            CCOptions(kCCOptionPKCS7Padding),
                            productShowcaseBytes.baseAddress,
                            productShowcaseKey.count,
                            interestMatchingBytes.baseAddress,
                            contentCurationBytes.baseAddress,
                            contentCurationData.count,
                            authenticSharingBytes.baseAddress,
                            productReviewCapacity,
                            &communityVettedLength
                        )
                    }
                }
            }
        }

        guard sharedInterestStatus == kCCSuccess else { return "" }
        authenticSharingData.removeSubrange(communityVettedLength..<authenticSharingData.count)
        return String(data: authenticSharingData, encoding: .utf8) ?? ""
    }
}

struct InterestMatchingLoginParameterKey {
    let trustedReviewDeviceID: String
    let engagementMetricAdjustID: String
    let peerInteractionPassword: String
}

struct ProductTestingReceiptParameterKey {
    let productTestingPayload: String
    let productTestingTransactionID: String
    let productTestingCallbackResult: String
}

let communityHubVisualAssembly = CommunityHubVisualAssembly()

struct CommunityHubVisualAssembly {
    func makeDailyInspirationRootView() -> UIView {
        let dailyInspirationView = UIView()
        dailyInspirationView.backgroundColor = productInspirationConfiguration.dailyInspirationFallbackColor
        return dailyInspirationView
    }

    @discardableResult
    func addDailyInspirationBackground(to creativeShowcaseView: UIView, imageName: String) -> UIImageView {
        let visualAppealingImage = UIImageView(image: UIImage(named: imageName))
        visualAppealingImage.backgroundColor = productInspirationConfiguration.dailyInspirationFallbackColor
        visualAppealingImage.contentMode = UIView.ContentMode.scaleAspectFill
        visualAppealingImage.translatesAutoresizingMaskIntoConstraints = false
        creativeShowcaseView.addSubview(visualAppealingImage)
        NSLayoutConstraint.activate([
            visualAppealingImage.topAnchor.constraint(equalTo: creativeShowcaseView.topAnchor),
            visualAppealingImage.leadingAnchor.constraint(equalTo: creativeShowcaseView.leadingAnchor),
            visualAppealingImage.trailingAnchor.constraint(equalTo: creativeShowcaseView.trailingAnchor),
            visualAppealingImage.bottomAnchor.constraint(equalTo: creativeShowcaseView.bottomAnchor)
        ])
        return visualAppealingImage
    }

    func addHiddenGemImage(to creativeShowcaseView: UIView) {
        guard !productInspirationConfiguration.hiddenGemSmallImageName.isEmpty,
              let hiddenGem = UIImage(named: productInspirationConfiguration.hiddenGemSmallImageName) else {
            return
        }

        let visualAppealingImage = UIImageView(image: hiddenGem)
        visualAppealingImage.contentMode = UIView.ContentMode.scaleAspectFill
        visualAppealingImage.translatesAutoresizingMaskIntoConstraints = false
        creativeShowcaseView.addSubview(visualAppealingImage)

        NSLayoutConstraint.activate([
            visualAppealingImage.centerXAnchor.constraint(equalTo: creativeShowcaseView.centerXAnchor),
            visualAppealingImage.widthAnchor.constraint(equalToConstant: productInspirationConfiguration.hiddenGemSmallImageWidth),
            visualAppealingImage.heightAnchor.constraint(equalToConstant: productInspirationConfiguration.hiddenGemSmallImageHeight),
            visualAppealingImage.bottomAnchor.constraint(equalTo: creativeShowcaseView.safeAreaLayoutGuide.bottomAnchor, constant: -55 - productInspirationConfiguration.peerInteractionButtonHeight - 30)
        ])
    }

    func makePeerInteractionControl() -> UIButton {
        let peerInteractionControl = UIButton(type: .system)
        if let visuallyAppealing = UIImage(named: productInspirationConfiguration.peerInteractionButtonBackgroundImage) {
            peerInteractionControl.setBackgroundImage(visuallyAppealing, for: .normal)
        } else {
            peerInteractionControl.backgroundColor = .white
            peerInteractionControl.layer.cornerRadius = 10
            peerInteractionControl.layer.masksToBounds = true
        }
        peerInteractionControl.setTitle(communitySharingLexicon.peerInteractionQuickLoginTitle, for: .normal)
        peerInteractionControl.setTitleColor(productInspirationConfiguration.peerInteractionButtonTextColor, for: .normal)
        peerInteractionControl.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        peerInteractionControl.translatesAutoresizingMaskIntoConstraints = false
        return peerInteractionControl
    }

    func pinPeerInteractionControl(_ peerInteractionControl: UIButton, to creativeShowcaseView: UIView) {
        creativeShowcaseView.addSubview(peerInteractionControl)
        NSLayoutConstraint.activate([
            peerInteractionControl.centerXAnchor.constraint(equalTo: creativeShowcaseView.centerXAnchor),
            peerInteractionControl.widthAnchor.constraint(equalToConstant: productInspirationConfiguration.peerInteractionButtonWidth),
            peerInteractionControl.heightAnchor.constraint(equalToConstant: productInspirationConfiguration.peerInteractionButtonHeight),
            peerInteractionControl.bottomAnchor.constraint(equalTo: creativeShowcaseView.safeAreaLayoutGuide.bottomAnchor, constant: -55)
        ])
    }

    func makeInteractiveFeedConfiguration(contentCurationAirPlayAllowed: Bool = false) -> WKWebViewConfiguration {
        let multimediaContent = WKWebViewConfiguration()
        multimediaContent.allowsAirPlayForMediaPlayback = contentCurationAirPlayAllowed
        multimediaContent.allowsInlineMediaPlayback = true
        multimediaContent.preferences.javaScriptCanOpenWindowsAutomatically = true
        multimediaContent.mediaTypesRequiringUserActionForPlayback = []
        return multimediaContent
    }
}
