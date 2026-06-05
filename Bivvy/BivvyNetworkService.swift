import Foundation

struct BivvyUserProfile {
    let userId: String
    let name: String
    let avatarURL: String?
    let about: String
    let friendsCount: String
    let followersCount: String
    let followingCount: String
    let likesCount: String
}

final class BivvyNetworkService {
    static let shared = BivvyNetworkService()
  
    private let baseURL = "http://www.digitrex88store.shop/backone"
    private let bundleId = "71388066"
    private let tokenKey = "bivvy_network_token"
    private let userIdKey = "bivvy_network_user_id"
    private let userNameKey = "bivvy_network_user_name"
    private let defaults = UserDefaults.standard

    private init() {}

    var token: String? {
        get { defaults.string(forKey: tokenKey) }
        set { defaults.set(newValue, forKey: tokenKey) }
    }

    var currentUserId: String? {
        get { defaults.string(forKey: userIdKey) }
        set { defaults.set(newValue, forKey: userIdKey) }
    }

    var currentUserName: String? {
        get { defaults.string(forKey: userNameKey) }
        set { defaults.set(newValue, forKey: userNameKey) }
    }

    func emailLogin(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        request(
            path: "/pxxqcqfez/ykbgsddj",
            payload: [
                "rareFind": bundleId,
                "retroFind": email,
                "antiqueCollection": password,
                "limitedEdition": "1"
            ]
        ) { [weak self] result in
            switch result {
            case .success(let json):
                self?.saveSession(from: json, fallbackName: email)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func register(draft: BivvyProfileDraft, completion: @escaping (Result<Void, Error>) -> Void) {
        request(
            path: "/pxxqcqfez/ykbgsddj",
            payload: [
                "rareFind": bundleId,
                "retroFind": draft.email,
                "antiqueCollection": draft.password,
                "exclusiveItem": draft.name,
                "limitedEdition": "2",
                "memberRecommendation": draft.about,
                "communityFavorite": ""
            ]
        ) { [weak self] result in
            switch result {
            case .success(let json):
                self?.saveSession(from: json, fallbackName: draft.name)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchRecommendationUsers(completion: @escaping (Result<[BivvyRecommendationUser], Error>) -> Void) {
        request(path: "/dxxqbpwnukz/iloyrhtibnbh", payload: ["recommendationFeed": bundleId]) { result in
            completion(result.map { json in
                BivvyJSON.dataItems(from: json).prefix(20).enumerated().map { index, item in
                    BivvyRecommendationUser(
                        id: BivvyJSON.string(item, keys: ["videoDiscovery", "userId", "id", "userID"]) ?? "remote-user-\(index)",
                        name: BivvyJSON.string(item, keys: ["productReview", "nickName", "nickname", "userName", "name"]) ?? "Bivvy User",
                        avatarName: "bivvy_tab_profile_idlesel",
                        avatarURL: BivvyJSON.string(item, keys: ["communityFind", "avatar", "avatarUrl", "headImg", "headImgUrl", "userAvatar"]),
                        brief: BivvyJSON.string(item, keys: ["itemCollection", "signature", "aboutMe", "intro"]) ?? "communityFind"
                    )
                }
            })
        }
    }

    func fetchVideos(page: Int, completion: @escaping (Result<[BivvyVideoItem], Error>) -> Void) {
        request(
            path: "/kugdwsxiyimmz/zbtmutmroriojsf",
            payload: [
                "interestGroup": bundleId,
                "unboxingVideo": page,
                "productDemo": 20,
                "authenticReview": "1",

                "communityHub": "1"
            ]
        ) { result in
            completion(result.map { json in
                BivvyJSON.dataItems(from: json).enumerated().compactMap { index, item in
                    guard let cover = BivvyJSON.string(item, keys: ["itemGifting", "videoImgUrl", "coverUrl", "videoCover", "dynamicImg"]) else {
                        return nil
                    }
                    return BivvyVideoItem(
                        id: BivvyJSON.string(item, keys: ["handpickedItem", "dynamicId", "id", "videoId"]) ?? "remote-video-\(index)",
                        category: ["For you", "Fun", "Friend"][index % 3],
                        userName: BivvyJSON.string(item, keys: ["interactiveFeed", "nickName", "nickname", "userName", "name"]) ?? "Bivvy Creator",
                        description: BivvyJSON.string(item, keys: ["hiddenGem", "trendingProduct", "content", "dynamicContent", "description", "title"]) ?? "authenticReview",
                        coverImageName: "bivvy_video_cover_featured",
                        coverURL: cover,
                        likes: BivvyJSON.countString(item, keys: ["videoUpload", "likeNum", "likeCount", "likes"]),
                        saves: BivvyJSON.countString(item, keys: ["communityMarket", "collectNum", "saveCount", "saves"]),
                        comments: BivvyJSON.countString(item, keys: ["productHighlight", "commentNum", "commentCount", "comments"]),
                        isLiked: BivvyJSON.bool(item, keys: ["smartDiscovery", "storeFlag", "isLike", "liked"]) ?? false
                    )
                }
            })
        }
    }

    func fetchProfile(completion: @escaping (Result<BivvyUserProfile, Error>) -> Void) {
        request(path: "/spdurxektvz/atfhqobdrmkvgz", payload: ["hobbyItem": currentUserId ?? "", "collectibleShowcase": "1"]) { result in
            completion(result.map { json in
                let item = BivvyJSON.firstObject(from: json)
                return BivvyUserProfile(
                    userId: BivvyJSON.string(item, keys: ["nicheInterest", "userId", "id", "userID"]) ?? self.currentUserId ?? "",
                    name: BivvyJSON.string(item, keys: ["passionateCommunity", "nickName", "nickname", "userName", "name"]) ?? self.currentUserName ?? "Bivvy User",
                    avatarURL: BivvyJSON.string(item, keys: ["engagedUser", "avatar", "avatarUrl", "headImg", "headImgUrl", "userAvatar"]),
                    about: BivvyJSON.string(item, keys: ["infiniteScroll", "signature", "aboutMe", "intro"]) ?? "Share usefulFind and everydayDiscovery.",
                    friendsCount: BivvyJSON.countString(item, keys: ["detailedReview", "friendNum", "friendsCount", "friends"]),
                    followersCount: BivvyJSON.countString(item, keys: ["inDepthLook", "fansNum", "followersCount", "followers"]),
                    followingCount: BivvyJSON.countString(item, keys: ["firstImpression", "followNum", "followingCount", "following"]),
                    likesCount: BivvyJSON.countString(item, keys: ["performanceReview", "likeNum", "likesCount", "likes"])
                )
            })
        }
    }

    func fetchMyContent(completion: @escaping (Result<[BivvyProfileItem], Error>) -> Void) {
        request(path: "/spdurxektvz/atfhqobdrmkvgz", payload: ["hobbyItem": currentUserId ?? "", "collectibleShowcase": "1"]) { result in
            completion(result.map { json in
                let root = BivvyJSON.firstObject(from: json)
                let list = root["honestReview"] as? [[String: Any]] ?? BivvyJSON.dataItems(from: json)
                return list.enumerated().map { index, item in
                    let imageURL = BivvyJSON.string(item, keys: ["itemGifting", "videoImgUrl", "dynamicImg", "coverUrl"])
                        ?? BivvyJSON.stringArray(item, keys: ["greenExchange", "declutterFind", "dynamicImgList", "imgList"]).first
                    return BivvyProfileItem(
                        imageName: ["bivvy_profile_grid_find_one", "bivvy_profile_grid_find_two", "bivvy_profile_grid_find_three"][index % 3],
                        imageURL: imageURL,
                        title: BivvyJSON.string(item, keys: ["hiddenGem", "trendingProduct", "content", "dynamicContent", "title"]) ?? "productShowcase",
                        dynamicId: BivvyJSON.string(item, keys: ["handpickedItem", "dynamicId", "id"])
                    )
                }
            })
        }
    }

    func like(dynamicId: String, completion: ((Result<Void, Error>) -> Void)? = nil) {
        request(path: "/sbphtdz/rfsdoukc", payload: ["dailyInspiration": dynamicId, "creativeVlog": currentUserId ?? "", "productInspiration": "1"]) { result in
            completion?(result.map { _ in () })
        }
    }

    private func request(path: String, payload: [String: Any], completion: @escaping (Result<Any, Error>) -> Void) {
        guard let url = URL(string: baseURL + path) else {
            completion(.failure(BivvyNetworkError.invalidURL))
            return
        }

        logRequest(path: path, payload: payload)

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(bundleId, forHTTPHeaderField: "key")
        request.setValue(token ?? "", forHTTPHeaderField: "token")
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error {
                    self.logFailure(path: path, error: error)
                    completion(.failure(error))
                    return
                }
                guard let data else {
                    self.logFailure(path: path, error: BivvyNetworkError.emptyData)
                    completion(.failure(BivvyNetworkError.emptyData))
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                    self.logResponse(path: path, json: json)
                    if let message = BivvyJSON.failureMessage(from: json) {
                        completion(.failure(BivvyNetworkError.server(message)))
                    } else {
                        completion(.success(json))
                    }
                } catch {
                    self.logFailure(path: path, error: error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private func logRequest(path: String, payload: [String: Any]) {
        #if DEBUG
        let tokenState = (token?.isEmpty == false) ? "present" : "empty"
        print("🌐 [Bivvy API Request] path=\(path)")
        print("🌐 [Bivvy API Request] token=\(tokenState), payload=\(payload)")
        #endif
    }

    private func logResponse(path: String, json: Any) {
        #if DEBUG
        print("✅ [Bivvy API Response] path=\(path)")
        print("✅ [Bivvy API Response] summary=\(BivvyJSON.debugSummary(from: json))")
        #endif
    }

    private func logFailure(path: String, error: Error) {
        #if DEBUG
        print("❌ [Bivvy API Failure] path=\(path), error=\(error.localizedDescription)")
        #endif
    }

    private func saveSession(from json: Any, fallbackName: String) {
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
            return "Invalid request URL."
        case .emptyData:
            return "The server returned no data."
        case .server(let message):
            return message
        }
    }
}

enum BivvyJSON {
    static func failureMessage(from json: Any) -> String? {
        guard let object = json as? [String: Any] else { return nil }
        let code = object["code"] ?? object["status"]
        if let code = code as? Int, ![0, 200, 200000].contains(code) { return string(object, keys: ["msg", "message"]) ?? "Request failed." }
        if let code = code as? String, !["0", "200", "200000", "success", "SUCCESS"].contains(code) { return string(object, keys: ["msg", "message"]) ?? "Request failed." }
        if let success = object["success"] as? Bool, success == false { return string(object, keys: ["msg", "message"]) ?? "Request failed." }
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
