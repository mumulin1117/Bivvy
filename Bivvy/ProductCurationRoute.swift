import Foundation

enum ProductCurationRoute {
    case recommendationEngine
    case userDiscovery(userDiscoveryId: String)
    case videoSnippet(handpickedDynamicId: String)
    case trustedReview(handpickedDynamicId: String)
    case smartFilter
    case authenticVoice
    case interestGroup(type: String)
    case communityBoard
    case trustedVoice
    case productMatching
    private static let productCurationCommunityHub = BivvyStringVault.routeCommunityHub
    private static let productReviewAppId = BivvyStringVault.appId

    func productCurationURL() -> URL? {
        URL(string: communityHubPath)
    }

    private var communityHubPath: String {
        let videoStreamingToken = BivvyNetworkService.shared.token ?? BivvyStringVault.tokenEmpty
        switch self {
        case .productMatching:
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageScreenplay)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        case .recommendationEngine:
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageCreateRole)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        case .userDiscovery(let userDiscoveryId):
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageHome)\(userDiscoveryId)\(BivvyStringVault.tokenQuery)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        case .videoSnippet(let handpickedDynamicId):
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageDynamic)\(handpickedDynamicId)\(BivvyStringVault.tokenQuery)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        case .trustedReview:
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageReport)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        case .smartFilter:
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageSetting)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        case .authenticVoice:
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageEdit)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        case .interestGroup(let interestGroupType):
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageAttention)\(interestGroupType)\(BivvyStringVault.tokenQuery)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        case .communityBoard:
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageAgreement)\(BivvyStringVault.typeOne)\(BivvyStringVault.tokenQuery)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        case .trustedVoice:
            return "\(Self.productCurationCommunityHub)\(BivvyStringVault.pageAgreement)\(BivvyStringVault.typeTwo)\(BivvyStringVault.tokenQuery)\(videoStreamingToken)\(BivvyStringVault.appIdQuery)\(Self.productReviewAppId)"
        }
    }
}

typealias BivvyH5Route = ProductCurationRoute
