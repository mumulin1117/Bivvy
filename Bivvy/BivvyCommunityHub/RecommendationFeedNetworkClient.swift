import Foundation

let recommendationFeedNetworkClient = RecommendationFeedNetworkClient()

final class RecommendationFeedNetworkClient {
    private struct RecommendationFeedRequestContext {
        let communityBoard: String
        let productTagging: [String: Any]
        let productTestingFlow: Bool
        let interactiveFeedURL: URL
        let contentFilteringString: String
        let request: URLRequest
    }

    private enum RecommendationFeedPreparation {
        case ready(RecommendationFeedRequestContext)
        case failed(Error)
    }

    private enum RecommendationFeedTransport {
        case payload(Data, URLResponse?)
        case failed(Error)
    }

    init() {}

    func recommendationFeedPost(
        communityBoard: String,
        productTagging: [String: Any],
        productTestingFlow: Bool = false,
        contentSharing: @escaping (Result<[String: Any]?, Error>) -> Void = { _ in }
    ) {
        switch makeRecommendationFeedRequestContext(communityBoard: communityBoard, productTagging: productTagging, productTestingFlow: productTestingFlow) {
        case .ready(let recommendationFeedContext):
            startRecommendationFeedRequest(recommendationFeedContext, contentSharing: contentSharing)
        case .failed(let authenticReviewError):
            contentSharing(.failure(authenticReviewError))
        }
    }

    private func makeRecommendationFeedRequestContext(
        communityBoard: String,
        productTagging: [String: Any],
        productTestingFlow: Bool
    ) -> RecommendationFeedPreparation {
        guard let interactiveFeedURL = URL(string: productInspirationConfiguration.recommendationFeedBaseURL + communityBoard) else {
            return .failed(NSError(domain: communitySharingLexicon.interactiveFeedURLErrorText, code: 400))
        }

        guard let contentFilteringString = makeContentFilteringBody(productTagging: productTagging),
              let productTestingBodyData = contentFilteringString.data(using: .utf8) else {
            return .failed(NSError(domain: communitySharingLexicon.contentFilteringErrorText, code: 401))
        }

        var recommendationFeedRequest = URLRequest(url: interactiveFeedURL)
        configureRecommendationFeedRequest(&recommendationFeedRequest, body: productTestingBodyData)

        return .ready(RecommendationFeedRequestContext(
            communityBoard: communityBoard,
            productTagging: productTagging,
            productTestingFlow: productTestingFlow,
            interactiveFeedURL: interactiveFeedURL,
            contentFilteringString: contentFilteringString,
            request: recommendationFeedRequest
        ))
    }

    private func makeContentFilteringBody(productTagging: [String: Any]) -> String? {
        guard let productReviewJSONString = productReviewJSONString(productTagging: productTagging),
              let smartDiscoveryCipher = SmartDiscoveryCipher() else {
            return nil
        }
        return smartDiscoveryCipher.smartDiscoveryEncrypt(productReviewJSONString)
    }

    private func configureRecommendationFeedRequest(_ recommendationFeedRequest: inout URLRequest, body productTestingBodyData: Data) {
        recommendationFeedRequest.httpMethod = communitySharingLexicon.recommendationFeedPostMethod
        recommendationFeedRequest.httpBody = productTestingBodyData
        recommendationFeedRequest.timeoutInterval = 15
        recommendationFeedHeaders().forEach {
            recommendationFeedRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
    }

    private func recommendationFeedHeaders() -> [(key: String, value: String)] {
        [
            (communitySharingLexicon.productCurationContentTypeHeader, communitySharingLexicon.productCurationJSON),
            (communitySharingLexicon.communityHubAppIDHeader, productInspirationConfiguration.communityHubAppID),
            (communitySharingLexicon.productCurationAppVersionHeader, Bundle.main.productCurationAppVersion),
            (communitySharingLexicon.trustedReviewDeviceHeader, trustedReviewKeychainStore.trustedReviewDeviceID()),
            (communitySharingLexicon.interestMatchingLanguageHeader, Locale.current.languageCode ?? ""),
            (communitySharingLexicon.videoStreamingLoginTokenHeader, UserDefaults.standard.string(forKey: communitySharingLexicon.userTokenStorageKey) ?? ""),
            (communitySharingLexicon.communityInteractionPushTokenHeader, UserDefaults.standard.string(forKey: communitySharingLexicon.pushTokenStorageKey) ?? "")
        ]
    }

    private func startRecommendationFeedRequest(
        _ recommendationFeedContext: RecommendationFeedRequestContext,
        contentSharing: @escaping (Result<[String: Any]?, Error>) -> Void
    ) {
        logRecommendationFeedRequest(
            communityBoard: recommendationFeedContext.communityBoard,
            interactiveFeedURL: recommendationFeedContext.interactiveFeedURL,
            recommendationFeedRequest: recommendationFeedContext.request,
            productTagging: recommendationFeedContext.productTagging,
            contentFilteringString: recommendationFeedContext.contentFilteringString
        )

        URLSession.shared.dataTask(with: recommendationFeedContext.request) { productReviewData, productReviewResponse, authenticReviewError in
            self.handleRecommendationFeedTransport(
                self.resolveRecommendationFeedTransport(data: productReviewData, response: productReviewResponse, error: authenticReviewError),
                context: recommendationFeedContext,
                contentSharing: contentSharing
            )
        }.resume()
    }

    private func resolveRecommendationFeedTransport(data productReviewData: Data?, response productReviewResponse: URLResponse?, error authenticReviewError: Error?) -> RecommendationFeedTransport {
        if let authenticReviewError {
            return .failed(authenticReviewError)
        }

        guard let productReviewData else {
            return .failed(NSError(domain: communitySharingLexicon.contentDiscoveryNoDataText, code: 1000))
        }

        return .payload(productReviewData, productReviewResponse)
    }

    private func handleRecommendationFeedTransport(
        _ recommendationFeedTransport: RecommendationFeedTransport,
        context recommendationFeedContext: RecommendationFeedRequestContext,
        contentSharing: @escaping (Result<[String: Any]?, Error>) -> Void
    ) {
        switch recommendationFeedTransport {
        case .payload(let productReviewData, let productReviewResponse):
            logRecommendationFeedResponse(
                communityBoard: recommendationFeedContext.communityBoard,
                productReviewResponse: productReviewResponse,
                productReviewData: productReviewData
            )
            contentFilteringResponse(
                communityBoard: recommendationFeedContext.communityBoard,
                productTestingFlow: recommendationFeedContext.productTestingFlow,
                creativeShowcase: productReviewData,
                contentSharing: contentSharing
            )
        case .failed(let authenticReviewError):
            logRecommendationFeedFailure(communityBoard: recommendationFeedContext.communityBoard, authenticReviewError: authenticReviewError)
            DispatchQueue.main.async { contentSharing(.failure(authenticReviewError)) }
        }
    }

    private func contentFilteringResponse(
        communityBoard: String,
        productTestingFlow: Bool,
        creativeShowcase: Data,
        contentSharing: @escaping (Result<[String: Any]?, Error>) -> Void
    ) {
        do {
            let productTestingJSON = try makeProductTestingJSON(creativeShowcase)

            if productTestingFlow {
                handleProductTestingResponse(communityBoard: communityBoard, productTestingJSON: productTestingJSON, contentSharing: contentSharing)
                return
            }

            let productTestingResult = try makeDecodedRecommendationFeedPayload(productTestingJSON)
            logRecommendationFeedDecodedPayload(communityBoard: communityBoard, productTestingResult: productTestingResult)

            DispatchQueue.main.async {
                contentSharing(.success(productTestingResult))
            }
        } catch let authenticReviewError {
            logRecommendationFeedFailure(communityBoard: communityBoard, authenticReviewError: authenticReviewError)
            DispatchQueue.main.async {
                contentSharing(.failure(authenticReviewError))
            }
        }
    }

    private func makeProductTestingJSON(_ creativeShowcase: Data) throws -> [String: Any] {
        guard let productTestingJSON = try JSONSerialization.jsonObject(with: creativeShowcase) as? [String: Any] else {
            throw NSError(domain: communitySharingLexicon.productTestingInvalidJSONText, code: 1001)
        }
        return productTestingJSON
    }

    private func handleProductTestingResponse(
        communityBoard: String,
        productTestingJSON: [String: Any],
        contentSharing: @escaping (Result<[String: Any]?, Error>) -> Void
    ) {
        guard productTestingJSON[communitySharingLexicon.productTestingCodeField] as? String == communitySharingLexicon.productTestingSuccessCode else {
            logRecommendationFeedDecodedPayload(communityBoard: communityBoard, productTestingResult: productTestingJSON)
            DispatchQueue.main.async {
                contentSharing(.failure(NSError(domain: communitySharingLexicon.productTestingErrorText, code: 1001)))
            }
            return
        }
        logRecommendationFeedDecodedPayload(communityBoard: communityBoard, productTestingResult: productTestingJSON)
        DispatchQueue.main.async { contentSharing(.success([:])) }
    }

    private func makeDecodedRecommendationFeedPayload(_ productTestingJSON: [String: Any]) throws -> [String: Any] {
        guard let code = productTestingJSON[communitySharingLexicon.productTestingCodeField] as? String,
              code == communitySharingLexicon.productTestingSuccessCode,
              let contentFilteringResult = productTestingJSON[communitySharingLexicon.productTestingResultKey] as? String else {
            throw NSError(domain: productTestingJSON[communitySharingLexicon.textResponseMessageKey] as? String ?? communitySharingLexicon.contentDiscoveryBackErrorText, code: 1002)
        }

        guard let smartDiscoveryCipher = SmartDiscoveryCipher(),
              let authenticReviewString = smartDiscoveryCipher.smartDiscoveryDecrypt(hexString: contentFilteringResult),
              let authenticReviewData = authenticReviewString.data(using: .utf8),
              let productTestingResult = try JSONSerialization.jsonObject(with: authenticReviewData) as? [String: Any] else {
            throw NSError(domain: communitySharingLexicon.contentFilteringErrorText, code: 1003)
        }
        return productTestingResult
    }

    func productReviewJSONString(productTagging: [String: Any]) -> String? {
        guard let productReviewData = try? JSONSerialization.data(withJSONObject: productTagging) else { return nil }
        return String(data: productReviewData, encoding: .utf8)
    }

    private func logRecommendationFeedRequest(
        communityBoard: String,
        interactiveFeedURL: URL,
        recommendationFeedRequest: URLRequest,
        productTagging: [String: Any],
        contentFilteringString: String
    ) {
        #if DEBUG
        print("========== BivvyCommunityHub Request ==========")
        print("path: \(communityBoard)")
        print("url: \(interactiveFeedURL.absoluteString)")
        print("method: \(recommendationFeedRequest.httpMethod ?? "")")
        print("headers: \(recommendationFeedRequest.allHTTPHeaderFields ?? [:])")
        print("parameters: \(productReviewPrettyJSONString(productTagging) ?? "\(productTagging)")")
        print("encryptedBody: \(contentFilteringString)")
        print("===============================================")
        #endif
    }

    private func logRecommendationFeedResponse(
        communityBoard: String,
        productReviewResponse: URLResponse?,
        productReviewData: Data
    ) {
        #if DEBUG
        let productReviewStatus = (productReviewResponse as? HTTPURLResponse)?.statusCode ?? -1
        let productReviewText = String(data: productReviewData, encoding: .utf8) ?? "<non-utf8-data>"
        print("========== BivvyCommunityHub Response =========")
        print("path: \(communityBoard)")
        print("statusCode: \(productReviewStatus)")
        print("rawData: \(productReviewText)")
        print("===============================================")
        #endif
    }

    private func logRecommendationFeedDecodedPayload(communityBoard: String, productTestingResult: [String: Any]) {
        #if DEBUG
        print("====== BivvyCommunityHub Decoded Response ======")
        print("path: \(communityBoard)")
        print("decodedData: \(productReviewPrettyJSONString(productTestingResult) ?? "\(productTestingResult)")")
        print("===============================================")
        #endif
    }

    private func logRecommendationFeedFailure(communityBoard: String, authenticReviewError: Error) {
        #if DEBUG
        print("========== BivvyCommunityHub Failure ==========")
        print("path: \(communityBoard)")
        print("error: \(authenticReviewError.localizedDescription)")
        print("===============================================")
        #endif
    }

    private func productReviewPrettyJSONString(_ productTagging: Any) -> String? {
        guard JSONSerialization.isValidJSONObject(productTagging),
              let productReviewData = try? JSONSerialization.data(withJSONObject: productTagging, options: [.prettyPrinted, .sortedKeys]) else {
            return nil
        }
        return String(data: productReviewData, encoding: .utf8)
    }
}

private extension Bundle {
    var productCurationAppVersion: String {
        object(forInfoDictionaryKey: communitySharingLexicon.productCurationBundleShortVersionKey) as? String ?? ""
    }
}
