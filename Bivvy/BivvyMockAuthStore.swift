import Foundation

struct BivvyProfileDraft {
    let email: String
    let password: String
    let name: String
    let gender: String
    let birthday: Date
    let about: String
}

final class BivvyMockAuthStore {
    static let shared = BivvyMockAuthStore()

    private let registeredUsersKey = "bivvy_registered_users"
    private let loggedInEmailKey = "bivvy_logged_in_email"
    private let defaults = UserDefaults.standard

    private init() {}

    var isLoggedIn: Bool {
        defaults.string(forKey: loggedInEmailKey) != nil
    }

    var currentEmail: String? {
        defaults.string(forKey: loggedInEmailKey)
    }

    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        BivvyNetworkService.shared.emailLogin(email: email, password: password) { result in
            guard case .success = result else {
                completion(result)
                return
            }
            self.defaults.set(email, forKey: self.loggedInEmailKey)
            completion(.success(()))
        }
    }

    func register(draft: BivvyProfileDraft, completion: @escaping (Result<Void, Error>) -> Void) {
        BivvyNetworkService.shared.register(draft: draft) { result in
            guard case .success = result else {
                completion(result)
                return
            }
            var users = self.users()
            users[draft.email] = draft.password
            self.defaults.set(users, forKey: self.registeredUsersKey)
            self.defaults.set(draft.email, forKey: self.loggedInEmailKey)
            completion(.success(()))
        }
    }

    private func users() -> [String: String] {
        defaults.dictionary(forKey: registeredUsersKey) as? [String: String] ?? [:]
    }

    enum AuthError: LocalizedError {
        case accountMissing
        case incorrectPassword
        case accountExists

        var errorDescription: String? {
            switch self {
            case .accountMissing:
                return "Account does not exist."
            case .incorrectPassword:
                return "Incorrect password."
            case .accountExists:
                return "Account already exists."
            }
        }
    }
}
