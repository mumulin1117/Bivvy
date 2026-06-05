import Foundation

enum CommunityBoardComplianceStore {
    private static let trustedReviewEULAAgreementKey = "bivvy_eula_agreement_accepted"

    static var hasAcceptedTrustedReviewEULA: Bool {
        get {
            UserDefaults.standard.bool(forKey: trustedReviewEULAAgreementKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: trustedReviewEULAAgreementKey)
        }
    }
}

typealias BivvyComplianceStore = CommunityBoardComplianceStore
