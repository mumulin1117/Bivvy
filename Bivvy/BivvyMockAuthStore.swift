import Foundation

struct CommunitySharingProfileDraft {
    let peerInteraction: String
    let contentFiltering: String
    let handpickedItem: String
    let interestMatching: String
    let dailyRoutine: Date
    let authenticReview: String
}

typealias BivvyProfileDraft = CommunitySharingProfileDraft

final class CommunitySharingAuthStore {
    static let communityHub = CommunitySharingAuthStore()

    private let interestGroupUsersStorageKey = "bivvy_registered_users"
    private let peerInteractionLoginStorageKey = "bivvy_logged_in_email"
    private let communityBoardDefaults = UserDefaults.standard

    private init() {}

    var personalizedFeedIsLoggedIn: Bool {
        communityBoardDefaults.string(forKey: peerInteractionLoginStorageKey) != nil
    }

    var currentPeerInteractionEmail: String? {
        communityBoardDefaults.string(forKey: peerInteractionLoginStorageKey)
    }

    func smartGadgetLogout() {
        communityBoardDefaults.removeObject(forKey: peerInteractionLoginStorageKey)
        BivvyNetworkService.shared.smartGadgetLogout()
    }

    func peerInteractionLogin(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        BivvyNetworkService.shared.peerInteractionEmailLogin(email: email, password: password) { productReviewResult in
            guard case .success = productReviewResult else {
                completion(productReviewResult)
                return
            }
            self.communityBoardDefaults.set(email, forKey: self.peerInteractionLoginStorageKey)
            completion(.success(()))
        }
    }

    func communitySharingRegister(communitySharingDraft: BivvyProfileDraft, completion: @escaping (Result<Void, Error>) -> Void) {
        BivvyNetworkService.shared.communitySharingRegister(communitySharingDraft: communitySharingDraft) { productReviewResult in
            guard case .success = productReviewResult else {
                completion(productReviewResult)
                return
            }
            var communitySharingUsers = self.loadCommunitySharingUsers()
            communitySharingUsers[communitySharingDraft.peerInteraction] = communitySharingDraft.contentFiltering
            self.communityBoardDefaults.set(communitySharingUsers, forKey: self.interestGroupUsersStorageKey)
            self.communityBoardDefaults.set(communitySharingDraft.peerInteraction, forKey: self.peerInteractionLoginStorageKey)
            completion(.success(()))
        }
    }

    private func loadCommunitySharingUsers() -> [String: String] {
        communityBoardDefaults.dictionary(forKey: interestGroupUsersStorageKey) as? [String: String] ?? [:]
    }

    enum CommunitySharingAuthError: LocalizedError {
        case hiddenGemAccountMissing
        case contentFilteringPasswordMismatch
        case sharedInterestAccountExists

        var errorDescription: String? {
            switch self {
            case .hiddenGemAccountMissing:
                return BivvyStringVault.accountMissing
            case .contentFilteringPasswordMismatch:
                return BivvyStringVault.passwordWrong
            case .sharedInterestAccountExists:
                return BivvyStringVault.exists
            }
        }
    }
}

typealias BivvyMockAuthStore = CommunitySharingAuthStore
