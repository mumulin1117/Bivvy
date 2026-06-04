import Foundation

enum BivvyH5Route {
    case aiAssistant
    case userProfile(userId: String)
    case videoDetail(dynamicId: String)
    case termsOfService
    case privacyPolicy

    private static let gateway = "http://modernlifestylehub99globalmarket.shop/#"
    private static let appId = "71388066"

    func url() -> URL? {
        URL(string: path)
    }

    private var path: String {
        let token = BivvyMockAuthStore.shared.currentEmail ?? ""
        switch self {
        case .aiAssistant:
            return "\(Self.gateway)pages/AIexpert/index?token=\(token)&appID=\(Self.appId)"
        case .userProfile(let userId):
            return "\(Self.gateway)pages/homepage/index?userId=\(userId)&token=\(token)&appID=\(Self.appId)"
        case .videoDetail(let dynamicId):
            return "\(Self.gateway)pages/DynamicDetails/index?dynamicId=\(dynamicId)&token=\(token)&appID=\(Self.appId)"
        case .termsOfService:
            return "\(Self.gateway)pages/Agreement/index?type=1&token=\(token)&appID=\(Self.appId)"
        case .privacyPolicy:
            return "\(Self.gateway)pages/Agreement/index?type=2&token=\(token)&appID=\(Self.appId)"
        }
    }
}
