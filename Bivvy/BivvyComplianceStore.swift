import Foundation

enum BivvyComplianceStore {
    private static let eulaAgreementKey = "bivvy_eula_agreement_accepted"

    static var hasAcceptedEULA: Bool {
        get {
            UserDefaults.standard.bool(forKey: eulaAgreementKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: eulaAgreementKey)
        }
    }
}
