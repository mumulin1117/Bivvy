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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            let users = self.users()
            guard let savedPassword = users[email] else {
                completion(.failure(AuthError.accountMissing))
                return
            }
            guard savedPassword == password else {
                completion(.failure(AuthError.incorrectPassword))
                return
            }
            self.defaults.set(email, forKey: self.loggedInEmailKey)
            completion(.success(()))
        }
    }

    func register(draft: BivvyProfileDraft, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            var users = self.users()
            guard users[draft.email] == nil else {
                completion(.failure(AuthError.accountExists))
                return
            }
            users[draft.email] = draft.password
            self.defaults.set(users, forKey: self.registeredUsersKey)
            self.defaults.set(draft.email, forKey: self.loggedInEmailKey)
            completion(.success(()))
        }
    }

    private func users() -> [String: String] {
        defaults.dictionary(forKey: registeredUsersKey) as? [String: String] ?? [
            "bivvy@example.com": "123456"
        ]
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
