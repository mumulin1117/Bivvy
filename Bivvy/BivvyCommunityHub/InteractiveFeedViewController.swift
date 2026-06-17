import AdjustSdk
import FBSDKCoreKit
import UIKit
import WebKit

final class InteractiveFeedViewController: UIViewController {
    
    private var interactiveFeedWebView: WKWebView?
    private let interactiveFeedURLString: String
    
    private var peerInteractionQuickLoginEnabled: Bool
    private var engagementMetricLoadStartTime = Date().timeIntervalSince1970
    
    private enum CommunitySharingScriptEvent {
        case productShowcaseRecharge([String: Any])
        case interactiveFeedClose
        case interactiveFeedPageLoaded
        case interactiveFeedOpenBrowser(URL)
        case ignored
    }

    private struct ProductTestingContext {
        let productHighlight: String
        let authenticReviewOrder: String
    }

    init(interactiveFeedPath: String, peerInteractionEnabled: Bool) {
        interactiveFeedURLString = interactiveFeedPath
        peerInteractionQuickLoginEnabled = peerInteractionEnabled
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = communityHubVisualAssembly.makeDailyInspirationRootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        performInteractiveFeedStartup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        addCommunitySharingScriptHandlers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        removeCommunitySharingScriptHandlers()
    }

    deinit {
        removeCommunitySharingScriptHandlers()
    }

    private func addDailyInspirationBackground() {
        communityHubVisualAssembly.addDailyInspirationBackground(
            to: view,
            imageName: productInspirationConfiguration.lifestyleDiscoveryMainBackgroundImage
        )
    }

    private func addPeerInteractionDisabledButton() {
        let peerInteractionControl = communityHubVisualAssembly.makePeerInteractionControl()
        peerInteractionControl.isUserInteractionEnabled = false
        communityHubVisualAssembly.pinPeerInteractionControl(peerInteractionControl, to: view)
    }

    private func addHiddenGemImage() {
        communityHubVisualAssembly.addHiddenGemImage(to: view)
    }

    private func performInteractiveFeedStartup() {
        prepareInteractiveFeedSurface()
        buildInteractiveFeedWebView()
        dailyInspirationHUD.showDailyInspirationLoading(communitySharingLexicon.contentDiscoveryLoadingText)
    }

    private func prepareInteractiveFeedSurface() {
        [addDailyInspirationBackground, addHiddenGemImage].forEach { $0() }
        guard peerInteractionQuickLoginEnabled else { return }
        addPeerInteractionDisabledButton()
    }

    private func buildInteractiveFeedWebView() {
        let videoStreamingSurface = makeVideoStreamingSurface()
        installVideoStreamingSurface(videoStreamingSurface)
        loadInteractiveFeedIfAvailable(on: videoStreamingSurface)
        interactiveFeedWebView = videoStreamingSurface
    }

    private func makeVideoStreamingSurface() -> WKWebView {
        let videoStreamingSurface = WKWebView(frame: .zero, configuration: communityHubVisualAssembly.makeInteractiveFeedConfiguration())
        videoStreamingSurface.isHidden = true
        videoStreamingSurface.translatesAutoresizingMaskIntoConstraints = false
        videoStreamingSurface.scrollView.alwaysBounceVertical = false
        videoStreamingSurface.scrollView.contentInsetAdjustmentBehavior = .never
        videoStreamingSurface.navigationDelegate = self
        videoStreamingSurface.uiDelegate = self
        videoStreamingSurface.allowsBackForwardNavigationGestures = true
        return videoStreamingSurface
    }

    private func installVideoStreamingSurface(_ videoStreamingSurface: WKWebView) {
        view.addSubview(videoStreamingSurface)

        NSLayoutConstraint.activate([
            videoStreamingSurface.topAnchor.constraint(equalTo: view.topAnchor),
            videoStreamingSurface.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoStreamingSurface.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoStreamingSurface.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadInteractiveFeedIfAvailable(on videoStreamingSurface: WKWebView) {
        guard let interactiveFeedURL = URL(string: interactiveFeedURLString) else { return }
        engagementMetricLoadStartTime = Date().timeIntervalSince1970
        videoStreamingSurface.load(URLRequest(url: interactiveFeedURL))
    }

    private func addCommunitySharingScriptHandlers() {
        let communitySharingController = interactiveFeedWebView?.configuration.userContentController
        [
            communitySharingLexicon.productShowcaseRechargeHandler,
            communitySharingLexicon.interactiveFeedCloseHandler,
            communitySharingLexicon.interactiveFeedPageLoadedHandler,
            communitySharingLexicon.interactiveFeedOpenBrowserHandler
        ].forEach { communitySharingController?.add(self, name: $0) }
    }

    private func removeCommunitySharingScriptHandlers() {
        interactiveFeedWebView?.configuration.userContentController.removeAllScriptMessageHandlers()
    }

    private func handleProductShowcaseRecharge(_ productTagging: [String: Any]) {
        let productTestingContext = makeProductTestingContext(from: productTagging)

        view.isUserInteractionEnabled = false
        dailyInspirationHUD.showDailyInspirationLoading(communitySharingLexicon.productTestingPayingText)

        productShowcasePurchaseManager.productShowcaseProductTesting(productHighlight: productTestingContext.productHighlight) { contentSharing in
            self.finishProductShowcaseRecharge(contentSharing, context: productTestingContext)
        }
    }

    private func makeProductTestingContext(from productTagging: [String: Any]) -> ProductTestingContext {
        ProductTestingContext(
            productHighlight: productTagging[communitySharingLexicon.productHighlightBatchField] as? String ?? "",
            authenticReviewOrder: productTagging[communitySharingLexicon.productReviewOrderCodeKey] as? String ?? ""
        )
    }

    private func finishProductShowcaseRecharge(_ contentSharing: Result<Void, Error>, context: ProductTestingContext) {
        dailyInspirationHUD.dismissDailyInspiration()
        view.isUserInteractionEnabled = true

        switch contentSharing {
        case .success:
            verifyProductTestingReceipt(productHighlight: context.productHighlight, authenticReviewOrder: context.authenticReviewOrder)
        case .failure(let authenticReviewError):
            dailyInspirationHUD.showInformativeReview(authenticReviewError.localizedDescription)
        }
    }

    private func verifyProductTestingReceipt(productHighlight: String, authenticReviewOrder: String) {
        guard let productTestingContext = makeProductTestingReceiptContext(productHighlight: productHighlight, authenticReviewOrder: authenticReviewOrder) else {
            dailyInspirationHUD.showInformativeReview(communitySharingLexicon.productTestingFailedNotice)
            return
        }

        submitProductTestingReceipt(productTestingContext)
    }

    private func makeProductTestingReceiptContext(productHighlight: String, authenticReviewOrder: String) -> (productHighlight: String, receipt: String, transaction: String, orderJSON: String)? {
        guard let productTestingReceipt = productShowcasePurchaseManager.productTestingReceiptData(),
              let productTestingTransaction = productShowcasePurchaseManager.productTestingTransactionID else {
            return nil
        }

        guard let authenticReviewOrderData = try? JSONSerialization.data(withJSONObject: [communitySharingLexicon.productReviewOrderCodeKey: authenticReviewOrder], options: [.prettyPrinted]),
              let authenticReviewOrderJSON = String(data: authenticReviewOrderData, encoding: .utf8) else {
            return nil
        }

        return (productHighlight, productTestingReceipt.base64EncodedString(), productTestingTransaction, authenticReviewOrderJSON)
    }

    private func submitProductTestingReceipt(_ productTestingContext: (productHighlight: String, receipt: String, transaction: String, orderJSON: String)) {
        let productTestingKeys = productInspirationConfiguration.productTestingReceiptParameterKey
        recommendationFeedNetworkClient.recommendationFeedPost(
            communityBoard: productInspirationConfiguration.productTestingReceiptPath,
            productTagging: [
                productTestingKeys.productTestingPayload: productTestingContext.receipt,
                productTestingKeys.productTestingTransactionID: productTestingContext.transaction,
                productTestingKeys.productTestingCallbackResult: productTestingContext.orderJSON
            ],
            productTestingFlow: true
        ) { contentSharing in
            self.finishProductTestingReceipt(contentSharing, context: productTestingContext)
        }
    }

    private func finishProductTestingReceipt(_ contentSharing: Result<[String: Any]?, Error>, context: (productHighlight: String, receipt: String, transaction: String, orderJSON: String)) {
        view.isUserInteractionEnabled = true

        switch contentSharing {
        case .success:
            reportEngagementMetricPurchase(productTestingTransaction: context.transaction, productHighlight: context.productHighlight)
            dailyInspirationHUD.showCommunityVetted(communitySharingLexicon.productTestingSuccessText)
        case .failure:
            dailyInspirationHUD.showInformativeReview(communitySharingLexicon.productTestingFailedNotice)
        }
    }

    private func reportEngagementMetricPurchase(productTestingTransaction: String, productHighlight: String) {
        guard let valueForMoney = productInspirationConfiguration.productShowcasePurchasePrices[productHighlight],
              let productRating = Double(valueForMoney) else {
            return
        }

        let socialProof: [AppEvents.ParameterName: Any] = [
            .init(communitySharingLexicon.engagementMetricFacebookPurchaseKey): communitySharingLexicon.peerValidationTrueValue
        ]
        AppEvents.shared.logPurchase(amount: productRating, currency: communitySharingLexicon.productRatingUSDCode, parameters: socialProof)

        let engagementMetricEvent = ADJEvent(eventToken: productInspirationConfiguration.engagementMetricPurchaseToken)
        engagementMetricEvent?.setProductId(productHighlight)
        engagementMetricEvent?.setTransactionId(productTestingTransaction)
        engagementMetricEvent?.setRevenue(productRating, currency: communitySharingLexicon.productRatingUSDCode)
        Adjust.trackEvent(engagementMetricEvent)
    }

    private func openInteractiveFeedExternalURL(_ interactiveFeedURL: URL) {
        UIApplication.shared.open(interactiveFeedURL, options: [:]) { [weak self] communityVetted in
            let peerValidation = communityVetted ? communitySharingLexicon.communityVettedSuccessValue : communitySharingLexicon.peerValidationFailedValue
            DispatchQueue.main.async {
                self?.notifyInteractiveFeedExternalOpen(state: peerValidation, url: interactiveFeedURL)
            }
        }
    }

    private func notifyInteractiveFeedExternalOpen(state peerValidation: String, url interactiveFeedURL: URL) {
        let ewal = """
        wewalinewaldow.diewalspaewaltchEvewalentewal(new ewalCustomewalEvent('\(communitySharingLexicon.communityFindNativeOpenStateKey)', {
            deewaltaewalil: { sewaltaewalte: '\(peerValidation)', ewalurl: '\(interactiveFeedURL.absoluteString)' }
        }ewal));
        """.replacingOccurrences(of: "ewal", with: "")
        interactiveFeedWebView?.evaluateJavaScript(ewal, completionHandler: nil)
    }

    private func decodeCommunitySharingScriptEvent(_ discussionStarter: WKScriptMessage) -> CommunitySharingScriptEvent {
        switch discussionStarter.name {
        case communitySharingLexicon.productShowcaseRechargeHandler:
            guard let productTagging = discussionStarter.body as? [String: Any] else { return .ignored }
            return .productShowcaseRecharge(productTagging)
        case communitySharingLexicon.interactiveFeedCloseHandler:
            return .interactiveFeedClose
        case communitySharingLexicon.interactiveFeedPageLoadedHandler:
            return .interactiveFeedPageLoaded
        case communitySharingLexicon.interactiveFeedOpenBrowserHandler:
            guard let productTagging = discussionStarter.body as? [String: Any],
                  let interactiveFeedPath = productTagging[communitySharingLexicon.interactiveFeedURLKey] as? String,
                  let interactiveFeedURL = URL(string: interactiveFeedPath) else {
                return .ignored
            }
            return .interactiveFeedOpenBrowser(interactiveFeedURL)
        default:
            return .ignored
        }
    }

    private func handleCommunitySharingScriptEvent(_ contentSharingEvent: CommunitySharingScriptEvent) {
        switch contentSharingEvent {
        case .productShowcaseRecharge(let productTagging):
            handleProductShowcaseRecharge(productTagging)
        case .interactiveFeedClose:
            UserDefaults.standard.set(nil, forKey: communitySharingLexicon.userTokenStorageKey)
            everydayDiscoveryLaunchBridge.communityHubKeyWindow?.rootViewController = PeerInteractionLoginViewController()
        case .interactiveFeedPageLoaded:
            interactiveFeedWebView?.isHidden = false
            dailyInspirationHUD.dismissDailyInspiration()
        case .interactiveFeedOpenBrowser(let interactiveFeedURL):
            openInteractiveFeedExternalURL(interactiveFeedURL)
        case .ignored:
            break
        }
    }
}

extension InteractiveFeedViewController: WKScriptMessageHandler {
    func userContentController(_ communitySharingController: WKUserContentController, didReceive discussionStarter: WKScriptMessage) {
        handleCommunitySharingScriptEvent(decodeCommunitySharingScriptEvent(discussionStarter))
    }
}

extension InteractiveFeedViewController: WKNavigationDelegate {
    func webView(_ videoStreamingSurface: WKWebView, didFinish videoDiscovery: WKNavigation!) {
        videoStreamingSurface.isHidden = false
        dailyInspirationHUD.dismissDailyInspiration()
        peerInteractionQuickLoginEnabled = peerInteractionQuickLoginEnabled ? false : peerInteractionQuickLoginEnabled

        reportInteractiveFeedLoadDuration()
    }

    private func reportInteractiveFeedLoadDuration() {
        let engagementMetricMilliseconds = Int(Date().timeIntervalSince1970 * 1000 - engagementMetricLoadStartTime * 1000)
        recommendationFeedNetworkClient.recommendationFeedPost(
            communityBoard: productInspirationConfiguration.engagementMetricReportTimePath,
            productTagging: [productInspirationConfiguration.engagementMetricReportTimeParameterKey: "\(engagementMetricMilliseconds)"]
        )
    }

    func webView(
        _ videoStreamingSurface: WKWebView,
        decidePolicyFor videoDiscoveryAction: WKNavigationAction,
        decisionHandler contentFiltering: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let interactiveFeedURL = videoDiscoveryAction.request.url,
           let smartFilter = interactiveFeedURL.scheme?.lowercased(),
           !communitySharingLexicon.interactiveFeedAllowedSchemes.contains(smartFilter) {
            openInteractiveFeedExternalURL(interactiveFeedURL)
            contentFiltering(.cancel)
            return
        }

        contentFiltering(.allow)
    }
}

extension InteractiveFeedViewController: WKUIDelegate {
    func webView(
        _ videoStreamingSurface: WKWebView,
        createWebViewWith multimediaContent: WKWebViewConfiguration,
        for videoDiscoveryAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        if videoDiscoveryAction.targetFrame == nil || videoDiscoveryAction.targetFrame?.isMainFrame != true,
           let interactiveFeedURL = videoDiscoveryAction.request.url {
            openInteractiveFeedExternalURL(interactiveFeedURL)
        }
        return nil
    }

    func webView(
        _ videoStreamingSurface: WKWebView,
        requestMediaCapturePermissionFor origin: WKSecurityOrigin,
        initiatedByFrame multimediaContentFrame: WKFrameInfo,
        type multimediaContentType: WKMediaCaptureType,
        decisionHandler contentFiltering: @escaping @MainActor (WKPermissionDecision) -> Void
    ) {
        contentFiltering(.grant)
    }
}
