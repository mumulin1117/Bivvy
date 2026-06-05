import Foundation

struct CommunityHubUserProfile {
    let userDiscoveryId: String
    let contentCreatorName: String
    let contentCreatorAvatarURL: String?
    let authenticVoiceAbout: String
    let peerInteractionFriendsCount: String
    let communityInteractionFollowersCount: String
    let interestMatchingFollowingCount: String
    let engagementMetricLikesCount: String
}

typealias BivvyUserProfile = CommunityHubUserProfile

private enum RecommendationEngineToken {
    static let rareFind = BivvyStringVault.communityText([239, 205, 150, 178, 125, 75, 56, 33])
    static let retroFind = BivvyStringVault.communityText([31, 229, 202, 185, 155, 106, 77, 60, 33])
    static let antiqueCollection = BivvyStringVault.communityText([7, 222, 211, 166, 144, 106, 105, 33, 20, 200, 198, 138, 133, 113, 77, 55, 50])
    static let limitedEdition = BivvyStringVault.communityText([188, 156, 102, 113, 36, 31, 206, 199, 154, 128, 113, 84, 48, 63])
    static let exclusiveItem = BivvyStringVault.communityText([158, 106, 113, 4, 30, 253, 202, 140, 129, 116, 90, 33, 54])
    static let memberRecommendation = BivvyStringVault.communityText([85, 34, 40, 29, 208, 222, 188, 150, 98, 104, 34, 24, 238, 241, 141, 145, 122, 84, 60, 62])
    static let communityFavorite = BivvyStringVault.communityText([12, 197, 211, 160, 156, 121, 100, 11, 2, 255, 202, 145, 129, 117, 84, 54, 48])
    static let recommendationFeed = BivvyStringVault.communityText([37, 12, 212, 252, 188, 156, 102, 113, 44, 31, 229, 198, 146, 153, 119, 90, 60, 33])
    static let videoDiscovery = BivvyStringVault.communityText([171, 129, 106, 115, 34, 24, 248, 202, 187, 155, 125, 93, 48, 37])
    static let userId = BivvyStringVault.communityText([155, 189, 106, 92, 42, 38])
    static let id = BivvyStringVault.communityText([61, 58])
    static let userID = BivvyStringVault.communityText([187, 189, 106, 92, 42, 38])
    static let remoteUser = BivvyStringVault.communityText([34, 119, 40, 8, 254, 142, 154, 128, 119, 84, 60, 33])
    static let productReview = BivvyStringVault.communityText([132, 106, 108, 59, 30, 217, 215, 156, 129, 124, 86, 43, 35])
    static let nickName = BivvyStringVault.communityText([238, 206, 158, 186, 115, 90, 48, 61])
    static let nickname = BivvyStringVault.communityText([238, 206, 158, 154, 115, 90, 48, 61])
    static let userName = BivvyStringVault.communityText([238, 206, 158, 186, 106, 92, 42, 38])
    static let bivvyUser = BivvyStringVault.communityText([63, 30, 248, 246, 223, 141, 110, 79, 48, 17])
    static let profileAvatarAsset = BivvyStringVault.communityText([236, 201, 190, 144, 83, 95, 36, 30, 12, 221, 211, 180, 156, 125, 117, 18, 25, 234, 215, 160, 141, 110, 79, 48, 49])
    static let communityFind = BivvyStringVault.communityText([151, 97, 108, 11, 2, 255, 202, 145, 129, 117, 84, 54, 48])
    static let avatar = BivvyStringVault.communityText([141, 149, 108, 88, 47, 50])
    static let avatarUrl = BivvyStringVault.communityText([23, 249, 246, 141, 149, 108, 88, 47, 50])
    static let headImg = BivvyStringVault.communityText([196, 146, 189, 124, 88, 60, 59])
    static let headImgUrl = BivvyStringVault.communityText([33, 9, 222, 196, 146, 189, 124, 88, 60, 59])
    static let userAvatar = BivvyStringVault.communityText([63, 26, 255, 194, 137, 181, 106, 92, 42, 38])
    static let itemCollection = BivvyStringVault.communityText([188, 156, 102, 113, 46, 30, 231, 207, 144, 183, 117, 92, 45, 58])
    static let signature = BivvyStringVault.communityText([30, 249, 214, 139, 149, 118, 94, 48, 32])
    static let aboutMeKey = BivvyStringVault.communityText([198, 178, 128, 109, 86, 59, 50])
    static let intro = BivvyStringVault.communityText([155, 106, 77, 55, 58])
    static let interestGroup = BivvyStringVault.communityText([131, 122, 106, 63, 60, 255, 208, 154, 134, 125, 77, 55, 58])
    static let unboxingVideo = BivvyStringVault.communityText([156, 106, 97, 36, 45, 236, 205, 150, 140, 119, 91, 55, 38])
    static let productDemo = BivvyStringVault.communityText([106, 32, 30, 207, 215, 156, 129, 124, 86, 43, 35])
    static let authenticReview = BivvyStringVault.communityText([205, 183, 154, 121, 96, 31, 24, 226, 215, 145, 145, 112, 77, 44, 50])
    static let communityHub = BivvyStringVault.communityText([109, 112, 5, 2, 255, 202, 145, 129, 117, 84, 54, 48])
    static let itemGifting = BivvyStringVault.communityText([98, 35, 18, 255, 197, 150, 179, 117, 92, 45, 58])
    static let videoImgUrl = BivvyStringVault.communityText([105, 63, 46, 236, 206, 182, 155, 125, 93, 48, 37])
    static let coverUrl = BivvyStringVault.communityText([231, 209, 170, 134, 125, 79, 54, 48])
    static let videoCover = BivvyStringVault.communityText([63, 30, 253, 204, 188, 155, 125, 93, 48, 37])
    static let dynamicImg = BivvyStringVault.communityText([42, 22, 194, 192, 150, 153, 121, 87, 32, 55])
    static let handpickedItem = BivvyStringVault.communityText([191, 150, 123, 76, 41, 30, 224, 192, 150, 132, 124, 87, 56, 59])
    static let dynamicId = BivvyStringVault.communityText([31, 194, 192, 150, 153, 121, 87, 32, 55])
    static let videoId = BivvyStringVault.communityText([199, 182, 155, 125, 93, 48, 37])
    static let remoteVideo = BivvyStringVault.communityText([222, 96, 96, 41, 18, 253, 142, 154, 128, 119, 84, 60, 33])
    static let forYou = BivvyStringVault.communityText([214, 144, 141, 56, 75, 54, 21])
    static let fun = BivvyStringVault.communityText([87, 44, 21])
    static let friend = BivvyStringVault.communityText([155, 154, 125, 80, 43, 21])
    static let bivvyCreator = BivvyStringVault.communityText([129, 96, 113, 44, 30, 249, 224, 223, 141, 110, 79, 48, 17])
    static let interactiveFeed = BivvyStringVault.communityText([222, 183, 150, 73, 96, 59, 18, 255, 192, 158, 134, 125, 77, 55, 58])
    static let hiddenGem = BivvyStringVault.communityText([22, 238, 228, 145, 145, 124, 93, 48, 59])
    static let trendingProduct = BivvyStringVault.communityText([206, 177, 134, 107, 106, 63, 43, 236, 205, 150, 144, 118, 92, 43, 39])
    static let content = BivvyStringVault.communityText([215, 145, 145, 108, 87, 54, 48])
    static let dynamicContent = BivvyStringVault.communityText([166, 157, 106, 113, 35, 20, 200, 192, 150, 153, 121, 87, 32, 55])
    static let description = BivvyStringVault.communityText([107, 34, 18, 255, 211, 150, 134, 123, 74, 60, 55])
    static let title = BivvyStringVault.communityText([145, 116, 77, 48, 39])
    static let fallbackReview = BivvyStringVault.communityText([205, 183, 154, 121, 96, 31, 24, 226, 215, 145, 145, 112, 77, 44, 50])
    static let videoCoverAsset = BivvyStringVault.communityText([47, 229, 222, 184, 129, 94, 94, 43, 30, 27, 212, 204, 189, 144, 80, 106, 40, 31, 226, 213, 160, 141, 110, 79, 48, 49])
    static let contentCreator = BivvyStringVault.communityText([160, 156, 123, 100, 40, 9, 200, 215, 145, 145, 108, 87, 54, 48])
    static let userImgUrl = BivvyStringVault.communityText([33, 9, 222, 196, 146, 189, 106, 92, 42, 38])
    static let videoUpload = BivvyStringVault.communityText([97, 44, 20, 231, 211, 170, 155, 125, 93, 48, 37])
    static let likeNum = BivvyStringVault.communityText([206, 138, 186, 125, 82, 48, 63])
    static let likeCount = BivvyStringVault.communityText([15, 229, 214, 144, 183, 125, 82, 48, 63])
    static let likes = BivvyStringVault.communityText([135, 125, 82, 48, 63])
    static let communityMarket = BivvyStringVault.communityText([206, 183, 152, 125, 100, 0, 2, 255, 202, 145, 129, 117, 84, 54, 48])
    static let collectNum = BivvyStringVault.communityText([32, 14, 197, 215, 156, 145, 116, 85, 54, 48])
    static let saveCount = BivvyStringVault.communityText([15, 229, 214, 144, 183, 125, 79, 56, 32])
    static let saves = BivvyStringVault.communityText([135, 125, 79, 56, 32])
    static let productHighlight = BivvyStringVault.communityText([197, 210, 181, 154, 99, 109, 42, 18, 195, 215, 156, 129, 124, 86, 43, 35])
    static let commentNum = BivvyStringVault.communityText([32, 14, 197, 215, 145, 145, 117, 84, 54, 48])
    static let commentCount = BivvyStringVault.communityText([123, 107, 56, 20, 200, 215, 145, 145, 117, 84, 54, 48])
    static let comments = BivvyStringVault.communityText([248, 215, 145, 145, 117, 84, 54, 48])
    static let smartDiscovery = BivvyStringVault.communityText([171, 129, 106, 115, 34, 24, 248, 202, 187, 128, 106, 88, 52, 32])
    static let storeFlag = BivvyStringVault.communityText([28, 234, 207, 185, 145, 106, 86, 45, 32])
    static let isLike = BivvyStringVault.communityText([154, 159, 113, 117, 42, 58])
    static let liked = BivvyStringVault.communityText([144, 125, 82, 48, 63])
    static let hobbyItem = BivvyStringVault.communityText([22, 238, 215, 182, 141, 122, 91, 54, 59])
    static let collectibleShowcase = BivvyStringVault.communityText([40, 50, 8, 210, 205, 189, 155, 92, 96, 33, 25, 226, 215, 156, 145, 116, 85, 54, 48])
    static let nicheInterest = BivvyStringVault.communityText([135, 124, 96, 63, 30, 255, 205, 182, 145, 112, 90, 48, 61])
    static let passionateCommunity = BivvyStringVault.communityText([52, 53, 0, 223, 207, 191, 158, 96, 70, 40, 15, 234, 205, 144, 157, 107, 74, 56, 35])
    static let engagedUser = BivvyStringVault.communityText([119, 40, 8, 222, 199, 154, 147, 121, 94, 55, 54])
    static let profileFallbackAbout = BivvyStringVault.communityText([247, 148, 119, 120, 32, 9, 228, 200, 152, 181, 126, 86, 59, 50, 242, 201, 187, 144, 31, 95, 35, 32, 73, 213, 212, 187, 181, 99, 112, 43, 30, 248, 214, 223, 145, 106, 88, 49, 0])
    static let detailedReview = BivvyStringVault.communityText([165, 150, 102, 115, 40, 41, 239, 198, 147, 157, 121, 77, 60, 55])
    static let friendNum = BivvyStringVault.communityText([22, 254, 237, 155, 154, 125, 80, 43, 53])
    static let friendsCount = BivvyStringVault.communityText([123, 107, 56, 20, 200, 208, 155, 154, 125, 80, 43, 53])
    static let friends = BivvyStringVault.communityText([208, 155, 154, 125, 80, 43, 53])
    static let inDepthLook = BivvyStringVault.communityText([110, 34, 20, 199, 203, 139, 132, 125, 125, 55, 58])
    static let fansNum = BivvyStringVault.communityText([206, 138, 186, 107, 87, 56, 53])
    static let followersCount = BivvyStringVault.communityText([166, 157, 122, 106, 14, 8, 249, 198, 136, 155, 116, 85, 54, 53])
    static let followers = BivvyStringVault.communityText([8, 249, 198, 136, 155, 116, 85, 54, 53])
    static let firstImpression = BivvyStringVault.communityText([212, 189, 154, 124, 118, 40, 9, 251, 206, 182, 128, 107, 75, 48, 53])
    static let followNum = BivvyStringVault.communityText([22, 254, 237, 136, 155, 116, 85, 54, 53])
    static let followingCount = BivvyStringVault.communityText([166, 157, 122, 106, 14, 28, 229, 202, 136, 155, 116, 85, 54, 53])
    static let following = BivvyStringVault.communityText([28, 229, 202, 136, 155, 116, 85, 54, 53])
    static let performanceReview = BivvyStringVault.communityText([30, 212, 211, 164, 150, 93, 96, 46, 21, 234, 206, 141, 155, 126, 75, 60, 35])
    static let likesCount = BivvyStringVault.communityText([57, 21, 254, 204, 188, 135, 125, 82, 48, 63])
    static let honestReview = BivvyStringVault.communityText([120, 96, 36, 13, 238, 241, 139, 135, 125, 87, 54, 59])
    static let greenExchange = BivvyStringVault.communityText([150, 104, 107, 44, 19, 232, 219, 186, 154, 125, 92, 43, 52])
    static let declutterFind = BivvyStringVault.communityText([151, 97, 108, 11, 9, 238, 215, 139, 129, 116, 90, 60, 55])
    static let dynamicImgList = BivvyStringVault.communityText([166, 128, 102, 73, 42, 22, 194, 192, 150, 153, 121, 87, 32, 55])
    static let imgList = BivvyStringVault.communityText([215, 140, 157, 84, 94, 52, 58])
    static let gridOne = BivvyStringVault.communityText([58, 37, 239, 243, 169, 155, 86, 93, 18, 37, 0, 195, 221, 141, 150, 99, 108, 43, 20, 249, 211, 160, 141, 110, 79, 48, 49])
    static let gridTwo = BivvyStringVault.communityText([48, 60, 244, 243, 169, 155, 86, 93, 18, 37, 0, 195, 221, 141, 150, 99, 108, 43, 20, 249, 211, 160, 141, 110, 79, 48, 49])
    static let gridThree = BivvyStringVault.communityText([98, 82, 45, 35, 244, 243, 169, 155, 86, 93, 18, 37, 0, 195, 221, 141, 150, 99, 108, 43, 20, 249, 211, 160, 141, 110, 79, 48, 49])
    static let dailyInspiration = BivvyStringVault.communityText([223, 213, 187, 135, 110, 119, 36, 11, 248, 205, 182, 141, 116, 80, 56, 55])
    static let creativeVlog = BivvyStringVault.communityText([104, 106, 33, 45, 238, 213, 150, 128, 121, 92, 43, 48])
    static let productInspiration = BivvyStringVault.communityText([47, 6, 216, 206, 179, 129, 102, 117, 62, 21, 194, 215, 156, 129, 124, 86, 43, 35])
    static let videoEngagement = BivvyStringVault.communityText([206, 188, 150, 98, 96, 42, 26, 236, 205, 186, 155, 125, 93, 48, 37])
    static let communityInteraction = BivvyStringVault.communityText([85, 34, 40, 29, 210, 219, 160, 150, 123, 107, 4, 2, 255, 202, 145, 129, 117, 84, 54, 48])
    static let discussionStarter = BivvyStringVault.communityText([27, 212, 206, 160, 146, 123, 86, 35, 20, 226, 208, 140, 129, 123, 74, 48, 55])
    static let topicThread = BivvyStringVault.communityText([97, 44, 30, 249, 203, 171, 151, 113, 73, 54, 39])
    static let lifestyleDiscovery = BivvyStringVault.communityText([56, 27, 212, 204, 189, 144, 124, 108, 9, 30, 231, 218, 139, 135, 125, 95, 48, 63])
    static let craftDiscovery = BivvyStringVault.communityText([171, 129, 106, 115, 34, 24, 248, 202, 187, 128, 126, 88, 43, 48])
    static let token = BivvyStringVault.communityText([154, 125, 82, 54, 39])
    static let accessToken = BivvyStringVault.communityText([107, 40, 16, 228, 247, 140, 135, 125, 90, 58, 50])
    static let userToken = BivvyStringVault.communityText([21, 238, 200, 144, 160, 106, 92, 42, 38])
    static let lifeChanger = BivvyStringVault.communityText([119, 40, 28, 229, 194, 151, 183, 125, 95, 48, 63])
    static let dailyEssential = BivvyStringVault.communityText([190, 146, 102, 113, 35, 30, 248, 208, 186, 141, 116, 80, 56, 55])
    static let code = BivvyStringVault.communityText([125, 93, 54, 48])
    static let status = BivvyStringVault.communityText([140, 129, 108, 88, 45, 32])
    static let msg = BivvyStringVault.communityText([94, 42, 62])
    static let message = BivvyStringVault.communityText([198, 152, 149, 107, 74, 60, 62])
    static let success = BivvyStringVault.communityText([208, 140, 145, 123, 90, 44, 32])
    static let successUpper = BivvyStringVault.communityText([240, 172, 177, 91, 122, 12, 0])
    static let list = BivvyStringVault.communityText([108, 74, 48, 63])
    static let rows = BivvyStringVault.communityText([107, 78, 54, 33])
    static let records = BivvyStringVault.communityText([208, 155, 134, 119, 90, 60, 33])
    static let dataList = BivvyStringVault.communityText([255, 208, 150, 184, 121, 77, 56, 55])
    static let items = BivvyStringVault.communityText([135, 117, 92, 45, 58])
    static let data = BivvyStringVault.communityText([121, 77, 56, 55])
    static let url = BivvyStringVault.communityText([85, 43, 38])
    static let imgUrl = BivvyStringVault.communityText([147, 134, 77, 94, 52, 58])
    static let imageUrl = BivvyStringVault.communityText([231, 209, 170, 145, 127, 88, 52, 58])
    static let trueText = BivvyStringVault.communityText([125, 76, 43, 39])
    static let zero = BivvyStringVault.communityText([99])
    static let nilText = BivvyStringVault.communityText([85, 48, 61])
    static let arrayCount = BivvyStringVault.communityText([56, 57, 21, 254, 204, 188, 141, 121, 75, 43, 50])
    static let codePrefix = BivvyStringVault.communityText([201, 125, 93, 54, 48])
    static let messagePrefix = BivvyStringVault.communityText([112, 30, 236, 194, 140, 135, 125, 84, 121, 127])
    static let dataKeysPrefix = BivvyStringVault.communityText([56, 62, 2, 238, 232, 158, 128, 121, 93, 121, 127])
    static let listCountPrefix = BivvyStringVault.communityText([50, 113, 35, 14, 228, 224, 139, 135, 113, 85, 121, 127])
    static let dataArrayPrefix = BivvyStringVault.communityText([84, 197, 212, 167, 156, 76, 124, 44, 9, 249, 226, 158, 128, 121, 93, 121, 127])
    static let keysPrefix = BivvyStringVault.communityText([158, 140, 141, 125, 82, 121, 127])
    static let nameKey = BivvyStringVault.communityText([125, 84, 56, 61])
    static let userDiscovery = BivvyStringVault.communityText([138, 125, 96, 59, 20, 232, 208, 150, 176, 106, 92, 42, 38])
    static let infiniteScroll = BivvyStringVault.communityText([190, 159, 96, 119, 46, 40, 238, 215, 150, 154, 113, 95, 55, 58])
    static let one = BivvyStringVault.communityText([98])
    static let twoHundred = BivvyStringVault.communityText([9, 105, 97])
    static let twoHundredK = BivvyStringVault.communityText([207, 196, 40, 9, 105, 97])
}

final class RecommendationEngineService {
    static let shared = RecommendationEngineService()
  
    private let recommendationEngineBaseURL = BivvyStringVault.networkBase
    private let productReviewBundleId = BivvyStringVault.appId
    private let videoStreamingTokenKey = BivvyStringVault.tokenKey
    private let userDiscoveryStorageKey = BivvyStringVault.userIdKey
    private let contentCreatorStorageKey = BivvyStringVault.userNameKey
    private let recommendationEngineDefaults = UserDefaults.standard

    private init() {}

    var token: String? {
        get { recommendationEngineDefaults.string(forKey: videoStreamingTokenKey) }
        set { recommendationEngineDefaults.set(newValue, forKey: videoStreamingTokenKey) }
    }

    var currentUserId: String? {
        get { recommendationEngineDefaults.string(forKey: userDiscoveryStorageKey) }
        set { recommendationEngineDefaults.set(newValue, forKey: userDiscoveryStorageKey) }
    }

    var currentUserName: String? {
        get { recommendationEngineDefaults.string(forKey: contentCreatorStorageKey) }
        set { recommendationEngineDefaults.set(newValue, forKey: contentCreatorStorageKey) }
    }

    func smartGadgetLogout() {
        token = nil
        currentUserId = nil
        currentUserName = nil
    }

    func peerInteractionEmailLogin(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        performRecommendationRequest(
            path: BivvyStringVault.loginPath,
            payload: [
                RecommendationEngineToken.rareFind: productReviewBundleId,
                RecommendationEngineToken.retroFind: email,
                RecommendationEngineToken.antiqueCollection: password,
                RecommendationEngineToken.limitedEdition: BivvyStringVault.typeOne
            ]
        ) { [weak self] result in
            switch result {
            case .success(let json):
                self?.saveCommunityHubSession(from: json, fallbackName: email)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func communitySharingRegister(communitySharingDraft: BivvyProfileDraft, completion: @escaping (Result<Void, Error>) -> Void) {
        performRecommendationRequest(
            path: BivvyStringVault.loginPath,
            payload: [
                RecommendationEngineToken.rareFind: productReviewBundleId,
                RecommendationEngineToken.retroFind: communitySharingDraft.peerInteraction,
                RecommendationEngineToken.antiqueCollection: communitySharingDraft.contentFiltering,
                RecommendationEngineToken.exclusiveItem: communitySharingDraft.handpickedItem,
                RecommendationEngineToken.limitedEdition: BivvyStringVault.typeTwo,
                RecommendationEngineToken.memberRecommendation: communitySharingDraft.authenticReview,
                RecommendationEngineToken.communityFavorite: BivvyStringVault.tokenEmpty
            ]
        ) { [weak self] result in
            switch result {
            case .success(let json):
                self?.saveCommunityHubSession(from: json, fallbackName: communitySharingDraft.handpickedItem)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchUserRecommendationProfiles(completion: @escaping (Result<[UserRecommendationProfile], Error>) -> Void) {
        performRecommendationRequest(path: BivvyStringVault.usersPath, payload: [RecommendationEngineToken.recommendationFeed: productReviewBundleId]) { result in
            completion(result.map { json in
                BivvyJSON.dataItems(from: json).prefix(20).enumerated().map { index, item in
                    UserRecommendationProfile(
                        productShowcaseId: BivvyJSON.string(item, keys: [RecommendationEngineToken.videoDiscovery, RecommendationEngineToken.userId, RecommendationEngineToken.id, RecommendationEngineToken.userID]) ?? "\(RecommendationEngineToken.remoteUser)\(index)",
                        contentCreatorName: BivvyJSON.string(item, keys: [RecommendationEngineToken.productReview, RecommendationEngineToken.nickName, RecommendationEngineToken.nickname, RecommendationEngineToken.userName, RecommendationEngineToken.nameKey]) ?? RecommendationEngineToken.bivvyUser,
                        contentCreatorAvatarName: RecommendationEngineToken.profileAvatarAsset,
                        contentCreatorAvatarURL: BivvyJSON.string(item, keys: [RecommendationEngineToken.communityFind, RecommendationEngineToken.avatar, RecommendationEngineToken.avatarUrl, RecommendationEngineToken.headImg, RecommendationEngineToken.headImgUrl, RecommendationEngineToken.userAvatar]),
                        conversationStarterBrief: BivvyJSON.string(item, keys: [RecommendationEngineToken.itemCollection, RecommendationEngineToken.signature, RecommendationEngineToken.aboutMeKey, RecommendationEngineToken.intro]) ?? BivvyStringVault.noData
                    )
                }
            })
        }
    }

    func fetchVideoDiscoverySnippets(page: Int, completion: @escaping (Result<[VideoDiscoverySnippetItem], Error>) -> Void) {
        performRecommendationRequest(
            path: BivvyStringVault.videosPath,
            payload: [
                RecommendationEngineToken.interestGroup: productReviewBundleId,
                RecommendationEngineToken.unboxingVideo: page,
                RecommendationEngineToken.productDemo: 20,
                RecommendationEngineToken.authenticReview: BivvyStringVault.typeOne,

                RecommendationEngineToken.communityHub: BivvyStringVault.typeOne
            ]
        ) { result in
            completion(result.map { json in
                BivvyJSON.dataItems(from: json).enumerated().compactMap { index, item in
                    guard let cover = BivvyJSON.string(item, keys: [RecommendationEngineToken.itemGifting, RecommendationEngineToken.videoImgUrl, RecommendationEngineToken.coverUrl, RecommendationEngineToken.videoCover, RecommendationEngineToken.dynamicImg]) else {
                        return nil
                    }
                    return VideoDiscoverySnippetItem(
                        productShowcaseId: BivvyJSON.string(item, keys: [RecommendationEngineToken.handpickedItem, RecommendationEngineToken.dynamicId, RecommendationEngineToken.id, RecommendationEngineToken.videoId]) ?? "\(RecommendationEngineToken.remoteVideo)\(index)",
                        userDiscoveryId: BivvyJSON.string(item, keys: [RecommendationEngineToken.userDiscovery, RecommendationEngineToken.userId]) ?? BivvyStringVault.tokenEmpty,
                        productCategoryName: [RecommendationEngineToken.forYou, RecommendationEngineToken.fun, RecommendationEngineToken.friend][index % 3],
                        contentCreatorName: BivvyJSON.string(item, keys: [RecommendationEngineToken.interactiveFeed, RecommendationEngineToken.nickName, RecommendationEngineToken.nickname, RecommendationEngineToken.userName, RecommendationEngineToken.nameKey]) ?? RecommendationEngineToken.bivvyCreator,
                        authenticReviewDescription: BivvyJSON.string(item, keys: [RecommendationEngineToken.hiddenGem, RecommendationEngineToken.trendingProduct, RecommendationEngineToken.content, RecommendationEngineToken.dynamicContent, RecommendationEngineToken.description, RecommendationEngineToken.title]) ?? RecommendationEngineToken.authenticReview,
                        videoSnippetCoverImageName: RecommendationEngineToken.videoCoverAsset,
                        videoStreamingCoverURL: cover,
                        contentCreatorAvatarURL: BivvyJSON.string(item, keys: [RecommendationEngineToken.contentCreator, RecommendationEngineToken.userImgUrl, RecommendationEngineToken.avatarUrl]),
                        engagementMetricLikes: BivvyJSON.countString(item, keys: [RecommendationEngineToken.videoUpload, RecommendationEngineToken.likeNum, RecommendationEngineToken.likeCount, RecommendationEngineToken.likes]),
                        savedItemCount: BivvyJSON.countString(item, keys: [RecommendationEngineToken.communityMarket, RecommendationEngineToken.collectNum, RecommendationEngineToken.saveCount, RecommendationEngineToken.saves]),
                        discussionStarterComments: BivvyJSON.countString(item, keys: [RecommendationEngineToken.productHighlight, RecommendationEngineToken.commentNum, RecommendationEngineToken.commentCount, RecommendationEngineToken.comments]),
                        videoEngagementIsLiked: BivvyJSON.bool(item, keys: [RecommendationEngineToken.smartDiscovery, RecommendationEngineToken.storeFlag, RecommendationEngineToken.isLike, RecommendationEngineToken.liked]) ?? false
                    )
                }
            })
        }
    }

    func fetchCommunityHubProfile(completion: @escaping (Result<CommunityHubUserProfile, Error>) -> Void) {
        performRecommendationRequest(path: BivvyStringVault.profilePath, payload: [RecommendationEngineToken.hobbyItem: currentUserId ?? BivvyStringVault.tokenEmpty, RecommendationEngineToken.collectibleShowcase: BivvyStringVault.typeOne]) { result in
            completion(result.map { json in
                let item = BivvyJSON.firstObject(from: json)
                return CommunityHubUserProfile(
                    userDiscoveryId: BivvyJSON.string(item, keys: [RecommendationEngineToken.nicheInterest, RecommendationEngineToken.userId, RecommendationEngineToken.id, RecommendationEngineToken.userID]) ?? self.currentUserId ?? BivvyStringVault.tokenEmpty,
                    contentCreatorName: BivvyJSON.string(item, keys: [RecommendationEngineToken.passionateCommunity, RecommendationEngineToken.nickName, RecommendationEngineToken.nickname, RecommendationEngineToken.userName, RecommendationEngineToken.nameKey]) ?? self.currentUserName ?? RecommendationEngineToken.bivvyUser,
                    contentCreatorAvatarURL: BivvyJSON.string(item, keys: [RecommendationEngineToken.engagedUser, RecommendationEngineToken.avatar, RecommendationEngineToken.avatarUrl, RecommendationEngineToken.headImg, RecommendationEngineToken.headImgUrl, RecommendationEngineToken.userAvatar]),
                    authenticVoiceAbout: BivvyJSON.string(item, keys: [RecommendationEngineToken.infiniteScroll, RecommendationEngineToken.signature, RecommendationEngineToken.aboutMeKey, RecommendationEngineToken.intro]) ?? RecommendationEngineToken.profileFallbackAbout,
                    peerInteractionFriendsCount: BivvyJSON.countString(item, keys: [RecommendationEngineToken.detailedReview, RecommendationEngineToken.friendNum, RecommendationEngineToken.friendsCount, RecommendationEngineToken.friends]),
                    communityInteractionFollowersCount: BivvyJSON.countString(item, keys: [RecommendationEngineToken.inDepthLook, RecommendationEngineToken.fansNum, RecommendationEngineToken.followersCount, RecommendationEngineToken.followers]),
                    interestMatchingFollowingCount: BivvyJSON.countString(item, keys: [RecommendationEngineToken.firstImpression, RecommendationEngineToken.followNum, RecommendationEngineToken.followingCount, RecommendationEngineToken.following]),
                    engagementMetricLikesCount: BivvyJSON.countString(item, keys: [RecommendationEngineToken.performanceReview, RecommendationEngineToken.likeNum, RecommendationEngineToken.likesCount, RecommendationEngineToken.likes])
                )
            })
        }
    }

    func fetchContentCreatorCollection(completion: @escaping (Result<[ContentCreatorProfileItem], Error>) -> Void) {
        performRecommendationRequest(path: BivvyStringVault.profilePath, payload: [RecommendationEngineToken.hobbyItem: currentUserId ?? BivvyStringVault.tokenEmpty, RecommendationEngineToken.collectibleShowcase: BivvyStringVault.typeOne]) { result in
            completion(result.map { json in
                let root = BivvyJSON.firstObject(from: json)
                let list = root[RecommendationEngineToken.honestReview] as? [[String: Any]] ?? BivvyJSON.dataItems(from: json)
                return list.enumerated().map { index, item in
                    let imageURL = BivvyJSON.string(item, keys: [RecommendationEngineToken.itemGifting, RecommendationEngineToken.videoImgUrl, RecommendationEngineToken.dynamicImg, RecommendationEngineToken.coverUrl])
                        ?? BivvyJSON.stringArray(item, keys: [RecommendationEngineToken.greenExchange, RecommendationEngineToken.declutterFind, RecommendationEngineToken.dynamicImgList, RecommendationEngineToken.imgList]).first
                    return ContentCreatorProfileItem(
                        productShowcaseImageName: [RecommendationEngineToken.gridOne, RecommendationEngineToken.gridTwo, RecommendationEngineToken.gridThree][index % 3],
                        productShowcaseImageURL: imageURL,
                        productHighlightTitle: BivvyJSON.string(item, keys: [RecommendationEngineToken.hiddenGem, RecommendationEngineToken.trendingProduct, RecommendationEngineToken.content, RecommendationEngineToken.dynamicContent, RecommendationEngineToken.title]) ?? BivvyStringVault.noData,
                        handpickedDynamicId: BivvyJSON.string(item, keys: [RecommendationEngineToken.handpickedItem, RecommendationEngineToken.dynamicId, RecommendationEngineToken.id])
                    )
                }
            })
        }
    }

    func sendVideoEngagementLike(handpickedDynamicId: String, completion: ((Result<Void, Error>) -> Void)? = nil) {
        performRecommendationRequest(path: BivvyStringVault.likePath, payload: [RecommendationEngineToken.dailyInspiration: handpickedDynamicId, RecommendationEngineToken.creativeVlog: currentUserId ?? BivvyStringVault.tokenEmpty, RecommendationEngineToken.productInspiration: BivvyStringVault.typeOne]) { result in
            completion?(result.map { _ in () })
        }
    }

    func blockPeerInteraction(userDiscoveryId: String, contentCreatorName: String, contentCreatorAvatarURL: String?, completion: ((Result<Void, Error>) -> Void)? = nil) {
        performRecommendationRequest(
            path: BivvyStringVault.blockPath,
            payload: [
                RecommendationEngineToken.videoEngagement: userDiscoveryId,
                RecommendationEngineToken.communityInteraction: contentCreatorName,
                RecommendationEngineToken.discussionStarter: contentCreatorAvatarURL ?? BivvyStringVault.tokenEmpty,
                RecommendationEngineToken.topicThread: BivvyStringVault.typeTwo,
                RecommendationEngineToken.lifestyleDiscovery: BivvyStringVault.typeOne
            ]
        ) { result in
            completion?(result.map { _ in () })
        }
    }

    private func performRecommendationRequest(path: String, payload: [String: Any], completion: @escaping (Result<Any, Error>) -> Void) {
        guard let url = URL(string: recommendationEngineBaseURL + path) else {
            completion(.failure(BivvyNetworkError.invalidURL))
            return
        }

        logRecommendationRequest(path: path, payload: payload)

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        request.httpMethod = BivvyStringVault.post
        request.setValue(BivvyStringVault.appJson, forHTTPHeaderField: BivvyStringVault.contentType)
        request.setValue(BivvyStringVault.appJson, forHTTPHeaderField: BivvyStringVault.accept)
        request.setValue(productReviewBundleId, forHTTPHeaderField: BivvyStringVault.key)
        request.setValue(token ?? BivvyStringVault.tokenEmpty, forHTTPHeaderField: BivvyStringVault.token)
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error {
                    self.logRecommendationFailure(path: path, error: error)
                    completion(.failure(error))
                    return
                }
                guard let data else {
                    self.logRecommendationFailure(path: path, error: BivvyNetworkError.emptyData)
                    completion(.failure(BivvyNetworkError.emptyData))
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                    self.logRecommendationResponse(path: path, json: json)
                    if let message = BivvyJSON.failureMessage(from: json) {
                        completion(.failure(BivvyNetworkError.server(message)))
                    } else {
                        completion(.success(json))
                    }
                } catch {
                    self.logRecommendationFailure(path: path, error: error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private func logRecommendationRequest(path: String, payload: [String: Any]) {
        #if DEBUG
        let tokenState = (token?.isEmpty == false) ? BivvyStringVault.present : BivvyStringVault.empty
        print("\(BivvyStringVault.apiReq1)\(path)")
        print("\(BivvyStringVault.apiReq2)\(tokenState)\(BivvyStringVault.payload)\(payload)")
        #endif
    }

    private func logRecommendationResponse(path: String, json: Any) {
        #if DEBUG
        print("\(BivvyStringVault.apiRes1)\(path)")
        print("\(BivvyStringVault.apiRes2)\(BivvyJSON.debugSummary(from: json))")
        #endif
    }

    private func logRecommendationFailure(path: String, error: Error) {
        #if DEBUG
        print("\(BivvyStringVault.apiFail)\(path)\(BivvyStringVault.errorText)\(error.localizedDescription)")
        #endif
    }

    private func saveCommunityHubSession(from json: Any, fallbackName: String) {
        let object = BivvyJSON.firstObject(from: json)
        token = BivvyJSON.string(object, keys: [RecommendationEngineToken.craftDiscovery, RecommendationEngineToken.token, RecommendationEngineToken.accessToken, RecommendationEngineToken.userToken]) ?? token
        currentUserId = BivvyJSON.string(object, keys: [RecommendationEngineToken.lifeChanger, RecommendationEngineToken.userId, RecommendationEngineToken.id, RecommendationEngineToken.userID]) ?? currentUserId
        currentUserName = BivvyJSON.string(object, keys: [RecommendationEngineToken.dailyEssential, RecommendationEngineToken.nickName, RecommendationEngineToken.nickname, RecommendationEngineToken.userName, RecommendationEngineToken.nameKey]) ?? fallbackName
    }
}

enum BivvyNetworkError: LocalizedError {
    case invalidURL
    case emptyData
    case server(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return BivvyStringVault.invalidURL
        case .emptyData:
            return BivvyStringVault.emptyData
        case .server(let message):
            return message
        }
    }
}

enum BivvyJSON {
    static func failureMessage(from json: Any) -> String? {
        guard let object = json as? [String: Any] else { return nil }
        let code = object[RecommendationEngineToken.code] ?? object[RecommendationEngineToken.status]
        if let code = code as? Int, ![0, 200, 200000].contains(code) { return string(object, keys: [RecommendationEngineToken.msg, RecommendationEngineToken.message]) ?? BivvyStringVault.requestFailed }
        if let code = code as? String, ![RecommendationEngineToken.zero, RecommendationEngineToken.twoHundred, RecommendationEngineToken.twoHundredK, RecommendationEngineToken.success, RecommendationEngineToken.successUpper].contains(code) { return string(object, keys: [RecommendationEngineToken.msg, RecommendationEngineToken.message]) ?? BivvyStringVault.requestFailed }
        if let success = object[RecommendationEngineToken.success] as? Bool, success == false { return string(object, keys: [RecommendationEngineToken.msg, RecommendationEngineToken.message]) ?? BivvyStringVault.requestFailed }
        return nil
    }

    static func items(from json: Any) -> [[String: Any]] {
        let root = firstObject(from: json)
        for key in [RecommendationEngineToken.list, RecommendationEngineToken.rows, RecommendationEngineToken.records, RecommendationEngineToken.dataList, RecommendationEngineToken.items] {
            if let list = root[key] as? [[String: Any]] { return list }
        }
        if let list = (json as? [String: Any])?[RecommendationEngineToken.data] as? [[String: Any]] { return list }
        if let list = json as? [[String: Any]] { return list }
        return []
    }

    static func dataItems(from json: Any) -> [[String: Any]] {
        guard let object = json as? [String: Any] else {
            return json as? [[String: Any]] ?? []
        }

        if let dataArray = object[RecommendationEngineToken.data] as? [[String: Any]] {
            return dataArray
        }

        if let dataObject = object[RecommendationEngineToken.data] as? [String: Any] {
            for key in [RecommendationEngineToken.records, RecommendationEngineToken.list, RecommendationEngineToken.rows, RecommendationEngineToken.dataList, RecommendationEngineToken.items] {
                if let list = dataObject[key] as? [[String: Any]] {
                    return list
                }
            }
        }

        return items(from: json)
    }

    static func firstObject(from json: Any) -> [String: Any] {
        if let object = json as? [String: Any] {
            if let data = object[RecommendationEngineToken.data] as? [String: Any] { return data }
            return object
        }
        if let list = json as? [[String: Any]] { return list.first ?? [:] }
        return [:]
    }

    static func string(_ object: [String: Any], keys: [String]) -> String? {
        for key in keys {
            if let value = object[key] as? String, !value.isEmpty { return value }
            if let value = object[key] as? Int { return "\(value)" }
            if let value = object[key] as? Double { return "\(Int(value))" }
        }
        return nil
    }

    static func countString(_ object: [String: Any], keys: [String]) -> String {
        string(object, keys: keys) ?? RecommendationEngineToken.zero
    }

    static func bool(_ object: [String: Any], keys: [String]) -> Bool? {
        for key in keys {
            if let value = object[key] as? Bool { return value }
            if let value = object[key] as? Int { return value != 0 }
            if let value = object[key] as? String { return value == RecommendationEngineToken.one || value.lowercased() == RecommendationEngineToken.trueText }
        }
        return nil
    }

    static func stringArray(_ object: [String: Any], keys: [String]) -> [String] {
        for key in keys {
            if let values = object[key] as? [String] { return values }
            if let values = object[key] as? [[String: Any]] {
                return values.compactMap { string($0, keys: [RecommendationEngineToken.url, RecommendationEngineToken.imgUrl, RecommendationEngineToken.imageUrl]) }
            }
        }
        return []
    }

    static func debugSummary(from json: Any) -> String {
        guard let object = json as? [String: Any] else {
            if let list = json as? [Any] {
                return "\(RecommendationEngineToken.arrayCount)\(list.count)"
            }
            return "\(json)"
        }

        let code = object[RecommendationEngineToken.code] ?? object[RecommendationEngineToken.status] ?? RecommendationEngineToken.nilText
        let message = object[RecommendationEngineToken.msg] ?? object[RecommendationEngineToken.message] ?? RecommendationEngineToken.nilText
        let data = object[RecommendationEngineToken.data]
        let listCount = dataItems(from: json).count

        if let dataObject = data as? [String: Any] {
            return "\(RecommendationEngineToken.codePrefix)\(code)\(RecommendationEngineToken.messagePrefix)\(message)\(RecommendationEngineToken.dataKeysPrefix)\(Array(dataObject.keys))\(RecommendationEngineToken.listCountPrefix)\(listCount)"
        }
        if let dataArray = data as? [Any] {
            return "\(RecommendationEngineToken.codePrefix)\(code)\(RecommendationEngineToken.messagePrefix)\(message)\(RecommendationEngineToken.dataArrayPrefix)\(dataArray.count)\(RecommendationEngineToken.listCountPrefix)\(listCount)"
        }
        return "\(RecommendationEngineToken.codePrefix)\(code)\(RecommendationEngineToken.messagePrefix)\(message)\(RecommendationEngineToken.keysPrefix)\(Array(object.keys))\(RecommendationEngineToken.listCountPrefix)\(listCount)"
    }
}

typealias BivvyNetworkService = RecommendationEngineService
