import Foundation

enum BivvyH5Route {
    case aiAssistant
    case userProfile(userId: String)
    case videoDetail(dynamicId: String)
    case report(dynamicId: String)
    case settings
    case editProfile
    case followList(type: String)
    case termsOfService
    case privacyPolicy
    case CreateRole
    private static let gateway = "http://www.digitrex88store.shop/#"
    private static let appId = "71388066"

    func url() -> URL? {
        URL(string: path)
    }

    private var path: String {
        let token = BivvyNetworkService.shared.token ?? ""
        switch self {
        case .CreateRole:
            return "\(Self.gateway)pages/screenplay/index?token=\(token)&appID=\(Self.appId)"
        case .aiAssistant:
            return "\(Self.gateway)pages/CreateRole/index?token=\(token)&appID=\(Self.appId)"
        case .userProfile(let userId):
            return "\(Self.gateway)pages/HomePage/index?userId=\(userId)&token=\(token)&appID=\(Self.appId)"
        case .videoDetail(let dynamicId):
            return "\(Self.gateway)pages/DynamicDetails/index?dynamicId=\(dynamicId)&token=\(token)&appID=\(Self.appId)"
        case .report:
            return "\(Self.gateway)pages/Report/index?token=\(token)&appID=\(Self.appId)"
        case .settings:
            return "\(Self.gateway)pages/Setting/index?token=\(token)&appID=\(Self.appId)"
        case .editProfile:
            return "\(Self.gateway)pages/EditData/index?token=\(token)&appID=\(Self.appId)"
        case .followList(let type):
            return "\(Self.gateway)pages/attention/index?type=\(type)&token=\(token)&appID=\(Self.appId)"
        case .termsOfService:
            return "\(Self.gateway)pages/Agreement/index?type=1&token=\(token)&appID=\(Self.appId)"
        case .privacyPolicy:
            return "\(Self.gateway)pages/Agreement/index?type=2&token=\(token)&appID=\(Self.appId)"
        }
    }
}
