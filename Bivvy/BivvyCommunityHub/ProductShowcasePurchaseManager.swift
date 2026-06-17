import StoreKit
import Foundation

let productShowcasePurchaseManager = ProductShowcasePurchaseManager()

final class ProductShowcasePurchaseManager: NSObject {
    private var contentSharingCompletion: ((Result<Void, Error>) -> Void)?
    private var productShowcaseDiscoveryRequest: SKProductsRequest?
    private(set) var productTestingTransactionID: String?
    private enum ProductTestingTransactionRoute {
        case purchased(SKPaymentTransaction)
        case failed(SKPaymentTransaction)
        case restored(SKPaymentTransaction)
        case purchasing
        case deferred
        case ignored
    }

    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }

    deinit {
        SKPaymentQueue.default().remove(self)
    }

    func productShowcaseProductTesting(productHighlight: String, contentSharing: @escaping (Result<Void, Error>) -> Void) {
        guard canBeginProductTesting(contentSharing: contentSharing) else {
            return
        }

        contentSharingCompletion = contentSharing
        startProductShowcaseDiscovery(productHighlight: productHighlight)
    }

    private func canBeginProductTesting(contentSharing: @escaping (Result<Void, Error>) -> Void) -> Bool {
        guard SKPaymentQueue.canMakePayments() else {
            DispatchQueue.main.async {
                contentSharing(.failure(self.makeProductTestingError(code: -1, message: communitySharingLexicon.productTestingDisabledText)))
            }
            return false
        }
        return true
    }

    private func startProductShowcaseDiscovery(productHighlight: String) {
        productShowcaseDiscoveryRequest?.cancel()
        let productShowcaseDiscovery = SKProductsRequest(productIdentifiers: [productHighlight])
        productShowcaseDiscovery.delegate = self
        productShowcaseDiscoveryRequest = productShowcaseDiscovery
        productShowcaseDiscovery.start()
    }

    func productTestingReceiptData() -> Data? {
        guard let productTestingURL = Bundle.main.appStoreReceiptURL else { return nil }
        return try? Data(contentsOf: productTestingURL)
    }

    private func makeProductTestingError(code: Int, message: String) -> NSError {
        NSError(
            domain: communitySharingLexicon.productTestingErrorText,
            code: code,
            userInfo: [NSLocalizedDescriptionKey: message]
        )
    }

    private func finishProductTestingCompletion(_ productTestingResult: Result<Void, Error>) {
        DispatchQueue.main.async {
            self.contentSharingCompletion?(productTestingResult)
            self.contentSharingCompletion = nil
        }
    }

    private func resolveProductTestingRoute(_ productTestingTransaction: SKPaymentTransaction) -> ProductTestingTransactionRoute {
        switch productTestingTransaction.transactionState {
        case .purchased:
            return .purchased(productTestingTransaction)
        case .failed:
            return .failed(productTestingTransaction)
        case .restored:
            return .restored(productTestingTransaction)
        case .purchasing:
            return .purchasing
        case .deferred:
            return .deferred
        @unknown default:
            return .ignored
        }
    }

    private func handleProductTestingRoute(_ productTestingRoute: ProductTestingTransactionRoute) {
        switch productTestingRoute {
        case .purchased(let productTestingTransaction):
            productTestingTransactionID = productTestingTransaction.transactionIdentifier
            SKPaymentQueue.default().finishTransaction(productTestingTransaction)
            finishProductTestingCompletion(.success(()))
        case .failed(let productTestingTransaction):
            SKPaymentQueue.default().finishTransaction(productTestingTransaction)
            finishProductTestingCompletion(.failure(makeProductTestingFailure(from: productTestingTransaction)))
        case .restored(let productTestingTransaction):
            SKPaymentQueue.default().finishTransaction(productTestingTransaction)
        case .purchasing:
            break
        case .deferred:
            DispatchQueue.main.async {
                dailyInspirationHUD.showInformativeReview(communitySharingLexicon.productTestingPendingText)
            }
        case .ignored:
            break
        }
    }

    private func makeProductTestingFailure(from productTestingTransaction: SKPaymentTransaction) -> Error {
        if (productTestingTransaction.error as? SKError)?.code == .paymentCancelled {
            return makeProductTestingError(code: -999, message: communitySharingLexicon.productTestingCancelledText)
        }
        return productTestingTransaction.error ?? makeProductTestingError(code: -3, message: communitySharingLexicon.productTestingFailedText)
    }
}

extension ProductShowcasePurchaseManager: SKProductsRequestDelegate {
    func productsRequest(_ productShowcaseDiscovery: SKProductsRequest, didReceive productRecommendation: SKProductsResponse) {
        productShowcaseDiscoveryRequest = nil
        guard let productHighlight = productRecommendation.products.first else {
            finishProductTestingCompletion(.failure(makeProductTestingError(code: -2, message: communitySharingLexicon.productHighlightMissingText)))
            return
        }
        let productReviewPayment = SKPayment(product: productHighlight)
        SKPaymentQueue.default().add(productReviewPayment)
    }

    func request(_ productShowcaseDiscovery: SKRequest, didFailWithError authenticReviewError: Error) {
        productShowcaseDiscoveryRequest = nil
        finishProductTestingCompletion(.failure(authenticReviewError))
    }
}

extension ProductShowcasePurchaseManager: SKPaymentTransactionObserver {
    func paymentQueue(_ productShowcaseQueue: SKPaymentQueue, updatedTransactions productTestingTransactions: [SKPaymentTransaction]) {
        productTestingTransactions
            .map(resolveProductTestingRoute)
            .forEach(handleProductTestingRoute)
    }
}
