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
                "rareFind": productReviewBundleId,
                "retroFind": email,
                "antiqueCollection": password,
                "limitedEdition": BivvyStringVault.typeOne
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
                "rareFind": productReviewBundleId,
                "retroFind": communitySharingDraft.peerInteraction,
                "antiqueCollection": communitySharingDraft.contentFiltering,
                "exclusiveItem": communitySharingDraft.handpickedItem,
                "limitedEdition": BivvyStringVault.typeTwo,
                "memberRecommendation": communitySharingDraft.authenticReview,
                "communityFavorite": BivvyStringVault.tokenEmpty
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
        performRecommendationRequest(path: BivvyStringVault.usersPath, payload: ["recommendationFeed": productReviewBundleId]) { result in
            completion(result.map { json in
                BivvyJSON.dataItems(from: json).prefix(20).enumerated().map { index, item in
                    UserRecommendationProfile(
                        productShowcaseId: BivvyJSON.string(item, keys: ["videoDiscovery", "userId", "id", "userID"]) ?? "remote-user-\(index)",
                        contentCreatorName: BivvyJSON.string(item, keys: ["productReview", "nickName", "nickname", "userName", "name"]) ?? "Bivvy User",
                        contentCreatorAvatarName: "bivvy_tab_profile_idlesel",
                        contentCreatorAvatarURL: BivvyJSON.string(item, keys: ["communityFind", "avatar", "avatarUrl", "headImg", "headImgUrl", "userAvatar"]),
                        conversationStarterBrief: BivvyJSON.string(item, keys: ["itemCollection", "signature", "aboutMe", "intro"]) ?? BivvyStringVault.noData
                    )
                }
            })
        }
    }

    func fetchVideoDiscoverySnippets(page: Int, completion: @escaping (Result<[VideoDiscoverySnippetItem], Error>) -> Void) {
        performRecommendationRequest(
            path: BivvyStringVault.videosPath,
            payload: [
                "interestGroup": productReviewBundleId,
                "unboxingVideo": page,
                "productDemo": 20,
                "authenticReview": BivvyStringVault.typeOne,

                "communityHub": BivvyStringVault.typeOne
            ]
        ) { result in
            completion(result.map { json in
                BivvyJSON.dataItems(from: json).enumerated().compactMap { index, item in
                    guard let cover = BivvyJSON.string(item, keys: ["itemGifting", "videoImgUrl", "coverUrl", "videoCover", "dynamicImg"]) else {
                        return nil
                    }
                    return VideoDiscoverySnippetItem(
                        productShowcaseId: BivvyJSON.string(item, keys: ["handpickedItem", "dynamicId", "id", "videoId"]) ?? "remote-video-\(index)",
                        userDiscoveryId: BivvyJSON.string(item, keys: ["userDiscovery", "userId"]) ?? "",
                        productCategoryName: ["For you", "Fun", "Friend"][index % 3],
                        contentCreatorName: BivvyJSON.string(item, keys: ["interactiveFeed", "nickName", "nickname", "userName", "name"]) ?? "Bivvy Creator",
                        authenticReviewDescription: BivvyJSON.string(item, keys: ["hiddenGem", "trendingProduct", "content", "dynamicContent", "description", "title"]) ?? "authenticReview",
                        videoSnippetCoverImageName: "bivvy_video_cover_featured",
                        videoStreamingCoverURL: cover,
                        contentCreatorAvatarURL: BivvyJSON.string(item, keys: ["contentCreator", "userImgUrl", "avatarUrl"]),
                        engagementMetricLikes: BivvyJSON.countString(item, keys: ["videoUpload", "likeNum", "likeCount", "likes"]),
                        savedItemCount: BivvyJSON.countString(item, keys: ["communityMarket", "collectNum", "saveCount", "saves"]),
                        discussionStarterComments: BivvyJSON.countString(item, keys: ["productHighlight", "commentNum", "commentCount", "comments"]),
                        videoEngagementIsLiked: BivvyJSON.bool(item, keys: ["smartDiscovery", "storeFlag", "isLike", "liked"]) ?? false
                    )
                }
            })
        }
    }

    func fetchCommunityHubProfile(completion: @escaping (Result<CommunityHubUserProfile, Error>) -> Void) {
        performRecommendationRequest(path: BivvyStringVault.profilePath, payload: ["hobbyItem": currentUserId ?? BivvyStringVault.tokenEmpty, "collectibleShowcase": BivvyStringVault.typeOne]) { result in
            completion(result.map { json in
                let item = BivvyJSON.firstObject(from: json)
                return CommunityHubUserProfile(
                    userDiscoveryId: BivvyJSON.string(item, keys: ["nicheInterest", "userId", "id", "userID"]) ?? self.currentUserId ?? "",
                    contentCreatorName: BivvyJSON.string(item, keys: ["passionateCommunity", "nickName", "nickname", "userName", "name"]) ?? self.currentUserName ?? "Bivvy User",
                    contentCreatorAvatarURL: BivvyJSON.string(item, keys: ["engagedUser", "avatar", "avatarUrl", "headImg", "headImgUrl", "userAvatar"]),
                    authenticVoiceAbout: BivvyJSON.string(item, keys: ["infiniteScroll", "signature", "aboutMe", "intro"]) ?? "Share usefulFind and everydayDiscovery.",
                    peerInteractionFriendsCount: BivvyJSON.countString(item, keys: ["detailedReview", "friendNum", "friendsCount", "friends"]),
                    communityInteractionFollowersCount: BivvyJSON.countString(item, keys: ["inDepthLook", "fansNum", "followersCount", "followers"]),
                    interestMatchingFollowingCount: BivvyJSON.countString(item, keys: ["firstImpression", "followNum", "followingCount", "following"]),
                    engagementMetricLikesCount: BivvyJSON.countString(item, keys: ["performanceReview", "likeNum", "likesCount", "likes"])
                )
            })
        }
    }

    func fetchContentCreatorCollection(completion: @escaping (Result<[ContentCreatorProfileItem], Error>) -> Void) {
        performRecommendationRequest(path: BivvyStringVault.profilePath, payload: ["hobbyItem": currentUserId ?? BivvyStringVault.tokenEmpty, "collectibleShowcase": BivvyStringVault.typeOne]) { result in
            completion(result.map { json in
                let root = BivvyJSON.firstObject(from: json)
                let list = root["honestReview"] as? [[String: Any]] ?? BivvyJSON.dataItems(from: json)
                return list.enumerated().map { index, item in
                    let imageURL = BivvyJSON.string(item, keys: ["itemGifting", "videoImgUrl", "dynamicImg", "coverUrl"])
                        ?? BivvyJSON.stringArray(item, keys: ["greenExchange", "declutterFind", "dynamicImgList", "imgList"]).first
                    return ContentCreatorProfileItem(
                        productShowcaseImageName: ["bivvy_profile_grid_find_one", "bivvy_profile_grid_find_two", "bivvy_profile_grid_find_three"][index % 3],
                        productShowcaseImageURL: imageURL,
                        productHighlightTitle: BivvyJSON.string(item, keys: ["hiddenGem", "trendingProduct", "content", "dynamicContent", "title"]) ?? BivvyStringVault.noData,
                        handpickedDynamicId: BivvyJSON.string(item, keys: ["handpickedItem", "dynamicId", "id"])
                    )
                }
            })
        }
    }

    func sendVideoEngagementLike(handpickedDynamicId: String, completion: ((Result<Void, Error>) -> Void)? = nil) {
        performRecommendationRequest(path: BivvyStringVault.likePath, payload: ["dailyInspiration": handpickedDynamicId, "creativeVlog": currentUserId ?? BivvyStringVault.tokenEmpty, "productInspiration": BivvyStringVault.typeOne]) { result in
            completion?(result.map { _ in () })
        }
    }

    func blockPeerInteraction(userDiscoveryId: String, contentCreatorName: String, contentCreatorAvatarURL: String?, completion: ((Result<Void, Error>) -> Void)? = nil) {
        performRecommendationRequest(
            path: BivvyStringVault.blockPath,
            payload: [
                "videoEngagement": userDiscoveryId,
                "communityInteraction": contentCreatorName,
                "discussionStarter": contentCreatorAvatarURL ?? BivvyStringVault.tokenEmpty,
                "topicThread": BivvyStringVault.typeTwo,
                "lifestyleDiscovery": BivvyStringVault.typeOne
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
        token = BivvyJSON.string(object, keys: ["craftDiscovery", "token", "accessToken", "userToken"]) ?? token
        currentUserId = BivvyJSON.string(object, keys: ["lifeChanger", "userId", "id", "userID"]) ?? currentUserId
        currentUserName = BivvyJSON.string(object, keys: ["dailyEssential", "nickName", "nickname", "userName", "name"]) ?? fallbackName
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
        let code = object["code"] ?? object["status"]
        if let code = code as? Int, ![0, 200, 200000].contains(code) { return string(object, keys: ["msg", "message"]) ?? BivvyStringVault.requestFailed }
        if let code = code as? String, !["0", "200", "200000", "success", "SUCCESS"].contains(code) { return string(object, keys: ["msg", "message"]) ?? BivvyStringVault.requestFailed }
        if let success = object["success"] as? Bool, success == false { return string(object, keys: ["msg", "message"]) ?? BivvyStringVault.requestFailed }
        return nil
    }

    static func items(from json: Any) -> [[String: Any]] {
        let root = firstObject(from: json)
        for key in ["list", "rows", "records", "dataList", "items"] {
            if let list = root[key] as? [[String: Any]] { return list }
        }
        if let list = (json as? [String: Any])?["data"] as? [[String: Any]] { return list }
        if let list = json as? [[String: Any]] { return list }
        return []
    }

    static func dataItems(from json: Any) -> [[String: Any]] {
        guard let object = json as? [String: Any] else {
            return json as? [[String: Any]] ?? []
        }

        if let dataArray = object["data"] as? [[String: Any]] {
            return dataArray
        }

        if let dataObject = object["data"] as? [String: Any] {
            for key in ["records", "list", "rows", "dataList", "items"] {
                if let list = dataObject[key] as? [[String: Any]] {
                    return list
                }
            }
        }

        return items(from: json)
    }

    static func firstObject(from json: Any) -> [String: Any] {
        if let object = json as? [String: Any] {
            if let data = object["data"] as? [String: Any] { return data }
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
        string(object, keys: keys) ?? "0"
    }

    static func bool(_ object: [String: Any], keys: [String]) -> Bool? {
        for key in keys {
            if let value = object[key] as? Bool { return value }
            if let value = object[key] as? Int { return value != 0 }
            if let value = object[key] as? String { return value == "1" || value.lowercased() == "true" }
        }
        return nil
    }

    static func stringArray(_ object: [String: Any], keys: [String]) -> [String] {
        for key in keys {
            if let values = object[key] as? [String] { return values }
            if let values = object[key] as? [[String: Any]] {
                return values.compactMap { string($0, keys: ["url", "imgUrl", "imageUrl"]) }
            }
        }
        return []
    }

    static func debugSummary(from json: Any) -> String {
        guard let object = json as? [String: Any] else {
            if let list = json as? [Any] {
                return "arrayCount=\(list.count)"
            }
            return "\(json)"
        }

        let code = object["code"] ?? object["status"] ?? "nil"
        let message = object["msg"] ?? object["message"] ?? "nil"
        let data = object["data"]
        let listCount = dataItems(from: json).count

        if let dataObject = data as? [String: Any] {
            return "code=\(code), message=\(message), dataKeys=\(Array(dataObject.keys)), listCount=\(listCount)"
        }
        if let dataArray = data as? [Any] {
            return "code=\(code), message=\(message), dataArrayCount=\(dataArray.count), listCount=\(listCount)"
        }
        return "code=\(code), message=\(message), keys=\(Array(object.keys)), listCount=\(listCount)"
    }
}

typealias BivvyNetworkService = RecommendationEngineService
