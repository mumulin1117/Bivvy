import UIKit
import WebKit
import StoreKit
final class BivvyWebViewController: UIViewController, WKNavigationDelegate  ,WKScriptMessageHandler, WKUIDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    private let url: URL
    
    private let loadingView = UIActivityIndicatorView(style: .large)
    var purchaseIDItem:String?
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(colaofulei)
        colaofulei.frame = UIScreen.main.bounds
        buildLayout()
        normSeintView.load(URLRequest(url: url))
    }

    
    lazy var colaofulei: UIImageView = {
        let image = UIImageView.init(image: UIImage.init(named: "userPageNormalBg"))
        image.contentMode = .scaleAspectFill
        return image
    }()
 
   
    
    private lazy var normSeintView: WKWebView = {
        let normSeint = WKWebViewConfiguration()
        normSeint.mediaTypesRequiringUserActionForPlayback = []
        normSeint.allowsInlineMediaPlayback = true
        normSeint.preferences.javaScriptCanOpenWindowsAutomatically = true
        ["productReview", "everydayDiscovery", "greenExchange", "infiniteScroll", "contentDiscovery","smartGadget"].forEach { TOWINKLIopNode in
            normSeint.userContentController.add(self, name: TOWINKLIopNode)
        }
        
        let normSeintViewio = WKWebView(frame: UIScreen.main.bounds, configuration: normSeint)
        normSeintViewio.scrollView.showsVerticalScrollIndicator = false
        normSeintViewio.uiDelegate = self
        normSeintViewio.backgroundColor = .clear
        normSeintViewio.isHidden = true
        return normSeintViewio
    }()
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "productReview":
            guard let id = message.body as? String else { return }
            self.startingPusechaseCosin(id)
        case "greenExchange":
            if let stringDeepPath = message.body as? String ,
               let deppath = URL(string: stringDeepPath){
                let packdge = BivvyWebViewController(url:deppath )
                self.navigationController?.pushViewController(packdge, animated: true)
            }
        case "contentDiscovery","infiniteScroll":
            self.navigationController?.popViewController(animated: true)
       
        case "smartGadget"://app 退出登录
            break
//            TOWINKLIopVibeRoute.TOWINKLIopSessionToken = nil
//            UserDefaults.standard.set(nil, forKey: "wigCreator")
//            UserDefaults.standard.set(nil, forKey: "wigPioneer")
//            ((UIApplication.shared.delegate) as? AppDelegate)?.window?.rootViewController = BivvyAuthEntryViewController()
        default: break
        }
    }
    
    private func startingPusechaseCosin(_ TOWINKLIopId: String) {
        self.view.isUserInteractionEnabled = false
        self.loadingView.startAnimating()
        self.purchaseIDItem = TOWINKLIopId
        
        let TOWINKLIopSet = Set([TOWINKLIopId])
        let TOWINKLIopRequest = SKProductsRequest(productIdentifiers: TOWINKLIopSet)
        TOWINKLIopRequest.delegate = self
        TOWINKLIopRequest.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let TOWINKLIopValidItem = response.products.first {
            let TOWINKLIopBill = SKPayment(product: TOWINKLIopValidItem)
            SKPaymentQueue.default().add(TOWINKLIopBill)
        } else {
            self.view.isUserInteractionEnabled = true
            self.loadingView.stopAnimating()
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions Nolisting: [SKPaymentTransaction]) {
        for prue in Nolisting {
            switch prue.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(prue)
                self.normSeintView.evaluateJavaScript("everydayDiscovery()", completionHandler: nil)
               
                self.view.isUserInteractionEnabled = true
                self.loadingView.stopAnimating()
            case .failed:
                SKPaymentQueue.default().finishTransaction(prue)
                self.view.isUserInteractionEnabled = true
                self.loadingView.stopAnimating()
            case .restored:
                SKPaymentQueue.default().finishTransaction(prue)
            default: break
            }
        }
    }
    
   
    
   
    private func buildLayout() {
       

      

        normSeintView.translatesAutoresizingMaskIntoConstraints = false
        normSeintView.navigationDelegate = self
        normSeintView.scrollView.contentInsetAdjustmentBehavior = .never

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.color = BivvyAuthTheme.hotPink
        loadingView.startAnimating()

        [normSeintView, loadingView].forEach(view.addSubview)

        NSLayoutConstraint.activate([
            normSeintView.topAnchor.constraint(equalTo: view.topAnchor),
            normSeintView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            normSeintView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            normSeintView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

         
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
        normSeintView.isHidden = false
    }

    @objc private func close() {
        navigationController?.popViewController(animated: true)
    }
}
