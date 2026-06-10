import UIKit
import WebKit
import StoreKit
final class ProductShowcaseViewController: UIViewController, WKNavigationDelegate  ,WKScriptMessageHandler, WKUIDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    private let productShowcaseURL: URL
    
    private let smartDiscoveryLoadingView = UIActivityIndicatorView(style: .large)
    private var productReviewRequest: SKProductsRequest?
    var productReviewIdentifier: String?
    init(url: URL) {
        self.productShowcaseURL = url
        super.init(nibName: nil, bundle: nil)
        SKPaymentQueue.default().add(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        SKPaymentQueue.default().remove(self)
        guard isViewLoaded else { return }
        [
            BivvyStringVault.productReviewBridge,
            BivvyStringVault.everydayDiscoveryBridge,
            BivvyStringVault.greenExchangeBridge,
            BivvyStringVault.infiniteScrollBridge,
            BivvyStringVault.contentDiscoveryBridge,
            BivvyStringVault.smartGadgetBridge
        ].forEach { productShowcaseWebView.configuration.userContentController.removeScriptMessageHandler(forName: $0) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lifestyleDiscoveryBackgroundView)
        lifestyleDiscoveryBackgroundView.frame = UIScreen.main.bounds
        buildLayout()
        productShowcaseWebView.load(URLRequest(url: productShowcaseURL))
    }

    
    lazy var lifestyleDiscoveryBackgroundView: UIImageView = {
        let image = UIImageView.init(image: UIImage.init(named: "userPageNormalBg"))
        image.contentMode = .scaleAspectFill
        return image
    }()
 
   
    
    private lazy var productShowcaseWebView: WKWebView = {
        let productReviewConfiguration = WKWebViewConfiguration()
        productReviewConfiguration.mediaTypesRequiringUserActionForPlayback = []
        productReviewConfiguration.allowsInlineMediaPlayback = true
        productReviewConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = true
        [
            BivvyStringVault.productReviewBridge,
            BivvyStringVault.everydayDiscoveryBridge,
            BivvyStringVault.greenExchangeBridge,
            BivvyStringVault.infiniteScrollBridge,
            BivvyStringVault.contentDiscoveryBridge,
            BivvyStringVault.smartGadgetBridge
        ].forEach { smartDiscoveryNode in
            productReviewConfiguration.userContentController.add(self, name: smartDiscoveryNode)
        }
        
        let communityFindWebView = WKWebView(frame: UIScreen.main.bounds, configuration: productReviewConfiguration)
        communityFindWebView.scrollView.showsVerticalScrollIndicator = false
        communityFindWebView.uiDelegate = self
        communityFindWebView.backgroundColor = .clear
        communityFindWebView.isHidden = true
        return communityFindWebView
    }()
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case BivvyStringVault.productReviewBridge:
            guard let id = message.body as? String else { return }
            self.startProductReviewPurchase(id)
        case BivvyStringVault.greenExchangeBridge:
            if let productShowcasePath = message.body as? String,
               let productShowcaseURL = URL(string: productShowcasePath) {
                let communitySharingPage = BivvyWebViewController(url: productShowcaseURL)
                self.navigationController?.pushViewController(communitySharingPage, animated: true)
            }
        case BivvyStringVault.contentDiscoveryBridge, BivvyStringVault.infiniteScrollBridge:
            self.navigationController?.popViewController(animated: true)
       
        case BivvyStringVault.smartGadgetBridge:
            presentSmartGadgetLogout()
        default: break
        }
    }
    
    private func startProductReviewPurchase(_ productReviewId: String) {
        guard SKPaymentQueue.canMakePayments() else {
            view.isUserInteractionEnabled = true
            smartDiscoveryLoadingView.stopAnimating()
            presentProductReviewPaymentMessage(BivvyStringVault.paymentUnavailable)
            return
        }

        self.view.isUserInteractionEnabled = false
        self.smartDiscoveryLoadingView.startAnimating()
        self.productReviewIdentifier = productReviewId
        
        let productReviewSet = Set([productReviewId])
        let productReviewRequest = SKProductsRequest(productIdentifiers: productReviewSet)
        productReviewRequest.delegate = self
        self.productReviewRequest = productReviewRequest
        productReviewRequest.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        productReviewRequest = nil
        if let trustedReviewProduct = response.products.first {
            let productReviewPayment = SKPayment(product: trustedReviewProduct)
            SKPaymentQueue.default().add(productReviewPayment)
        } else {
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = true
                self.smartDiscoveryLoadingView.stopAnimating()
                self.presentProductReviewPaymentMessage(BivvyStringVault.productUnavailable)
            }
           
        }
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        productReviewRequest = nil
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.smartDiscoveryLoadingView.stopAnimating()
            self.presentProductReviewPaymentMessage(BivvyStringVault.paymentFailed)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions productReviewTransactions: [SKPaymentTransaction]) {
        for productReviewTransaction in productReviewTransactions {
            switch productReviewTransaction.transactionState {
            case .purchased:
                
                DispatchQueue.main.async {
                    SKPaymentQueue.default().finishTransaction(productReviewTransaction)
                    self.productShowcaseWebView.evaluateJavaScript(BivvyStringVault.everydayDiscoveryCallback, completionHandler: nil)
                   
                    self.view.isUserInteractionEnabled = true
                    self.smartDiscoveryLoadingView.stopAnimating()
                    self.presentProductReviewPaymentMessage(BivvyStringVault.paymentSuccessful)
                }
               
            case .failed:
                DispatchQueue.main.async {
                    SKPaymentQueue.default().finishTransaction(productReviewTransaction)
                    self.view.isUserInteractionEnabled = true
                    self.smartDiscoveryLoadingView.stopAnimating()
                    self.presentProductReviewPaymentMessage(BivvyStringVault.paymentFailed)
                }
                
            case .restored:
                DispatchQueue.main.async {
                    SKPaymentQueue.default().finishTransaction(productReviewTransaction)
                }
                
            default: break
            }
        }
    }

    private func presentProductReviewPaymentMessage(_ productReviewMessage: String) {
        guard presentedViewController == nil else { return }
        let productReviewAlert = UIAlertController(
            title: nil,
            message: productReviewMessage,
            preferredStyle: .alert
        )
        productReviewAlert.addAction(UIAlertAction(title: BivvyStringVault.ok, style: .default))
        present(productReviewAlert, animated: true)
    }
    
   
    
   
    private func buildLayout() {
       

      

        productShowcaseWebView.translatesAutoresizingMaskIntoConstraints = false
        productShowcaseWebView.navigationDelegate = self
        productShowcaseWebView.scrollView.contentInsetAdjustmentBehavior = .never

        smartDiscoveryLoadingView.translatesAutoresizingMaskIntoConstraints = false
        smartDiscoveryLoadingView.color = CommunitySharingAuthTheme.favoriteFindPink
        smartDiscoveryLoadingView.startAnimating()

        [productShowcaseWebView, smartDiscoveryLoadingView].forEach(view.addSubview)

        NSLayoutConstraint.activate([
            productShowcaseWebView.topAnchor.constraint(equalTo: view.topAnchor),
            productShowcaseWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productShowcaseWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productShowcaseWebView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

         
            smartDiscoveryLoadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smartDiscoveryLoadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        smartDiscoveryLoadingView.stopAnimating()
        productShowcaseWebView.isHidden = false
    }

    @objc private func close() {
        navigationController?.popViewController(animated: true)
    }

    private func presentSmartGadgetLogout() {
        let smartGadgetAlert = UIAlertController(
            title: BivvyStringVault.logOut,
            message: BivvyStringVault.logoutMsg,
            preferredStyle: .alert
        )
        smartGadgetAlert.addAction(UIAlertAction(title: BivvyStringVault.cancel, style: .cancel))
        smartGadgetAlert.addAction(UIAlertAction(title: BivvyStringVault.logOut, style: .destructive) { _ in
            CommunitySharingAuthStore.communityHub.smartGadgetLogout()
            (self.view.window?.windowScene?.delegate as? BivvySceneDelegate)?.showAuthInterface()
        })
        present(smartGadgetAlert, animated: true)
    }
}

typealias BivvyWebViewController = ProductShowcaseViewController
