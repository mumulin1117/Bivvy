import Foundation
import UIKit

let trustedReviewKeychainStore = TrustedReviewKeychainStore()

final class TrustedReviewKeychainStore {
    private var trustedReviewServiceName: String {
        Bundle.main.bundleIdentifier.map { "\($0).bivvy.communityHub" } ?? "com.bivvy.communityHub"
    }

    private var trustedReviewDeviceAccount: String {
        "\(trustedReviewServiceName).\(communitySharingLexicon.trustedReviewDeviceSuffix)"
    }

    private var peerInteractionPasswordAccount: String {
        "\(trustedReviewServiceName).\(communitySharingLexicon.peerInteractionPasswordSuffix)"
    }

    func trustedReviewDeviceID() -> String {
        if let savedItem = trustedReviewRead(communityVetted: trustedReviewDeviceAccount) {
            return savedItem
        }

        let handpickedItem = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        trustedReviewSave(handpickedItem, communityVetted: trustedReviewDeviceAccount)
        return handpickedItem
    }

    func savePeerInteractionPassword(_ password: String) {
        trustedReviewSave(password, communityVetted: peerInteractionPasswordAccount)
    }

    func peerInteractionSavedPassword() -> String? {
        trustedReviewRead(communityVetted: peerInteractionPasswordAccount)
    }

    private func trustedReviewRead(communityVetted: String) -> String? {
        let trustedReviewQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: trustedReviewServiceName,
            kSecAttrAccount as String: communityVetted,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var productTestingResult: AnyObject?
        let performanceReviewStatus = SecItemCopyMatching(trustedReviewQuery as CFDictionary, &productTestingResult)

        guard performanceReviewStatus == errSecSuccess,
              let productReviewData = productTestingResult as? Data,
              let authenticVoice = String(data: productReviewData, encoding: .utf8) else {
            return nil
        }
        return authenticVoice
    }

    private func trustedReviewSave(_ authenticReview: String, communityVetted: String) {
        trustedReviewDelete(communityVetted: communityVetted)
        guard let productReviewData = authenticReview.data(using: .utf8) else { return }

        let trustedReviewQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: trustedReviewServiceName,
            kSecAttrAccount as String: communityVetted,
            kSecValueData as String: productReviewData,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]

        SecItemAdd(trustedReviewQuery as CFDictionary, nil)
    }

    private func trustedReviewDelete(communityVetted: String) {
        let trustedReviewQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: trustedReviewServiceName,
            kSecAttrAccount as String: communityVetted
        ]
        SecItemDelete(trustedReviewQuery as CFDictionary)
    }
}

extension Data {
    func productReviewHexString() -> String {
        map { String(format: communitySharingLexicon.productReviewHexByteFormat, $0) }.joined()
    }

    init?(productReviewHexString authenticReview: String) {
        guard authenticReview.count % 2 == 0 else { return nil }
        var productTestingResult = Data()
        productTestingResult.reserveCapacity(authenticReview.count / 2)

        var contentCurationIndex = authenticReview.startIndex
        while contentCurationIndex < authenticReview.endIndex {
            let productReviewNextIndex = authenticReview.index(contentCurationIndex, offsetBy: 2)
            guard let productReviewByte = UInt8(authenticReview[contentCurationIndex..<productReviewNextIndex], radix: 16) else {
                return nil
            }
            productTestingResult.append(productReviewByte)
            contentCurationIndex = productReviewNextIndex
        }
        self = productTestingResult
    }

    func authenticReviewUTF8String() -> String? {
        String(data: self, encoding: .utf8)
    }
}
