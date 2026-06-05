import Foundation

final class BivvyLocalFindStore {
    static let shared = BivvyLocalFindStore()

    private let storageKey = "bivvy_local_find_items"
    private let defaults = UserDefaults.standard

    private init() {}

    var items: [BivvyFindItem] {
        loadUserItems() + BivvyMockContent.finds
    }

    func addFind(
        title: String,
        price: String,
        qualityGrade: String,
        city: String,
        exchangeDemand: String,
        category: String,
        imageName: String = "bivvy_find_card_daily",
        detailImageNames: [String]? = nil
    ) {
        var userItems = loadUserItems()
        let item = BivvyFindItem(
            id: UUID().uuidString,
            title: title,
            subtitle: category,
            imageName: imageName,
            likes: "0",
            saves: "0",
            detail: exchangeDemand,
            authorName: "You",
            createdAt: "Just now",
            price: price,
            qualityGrade: qualityGrade,
            city: city,
            exchangeDemand: exchangeDemand,
            category: category,
            detailImageNames: detailImageNames ?? [imageName]
        )
        userItems.insert(item, at: 0)
        saveUserItems(userItems)
    }

    private func loadUserItems() -> [BivvyFindItem] {
        guard let data = defaults.data(forKey: storageKey) else { return [] }
        return (try? JSONDecoder().decode([BivvyFindItem].self, from: data)) ?? []
    }

    private func saveUserItems(_ items: [BivvyFindItem]) {
        let data = try? JSONEncoder().encode(items)
        defaults.set(data, forKey: storageKey)
    }
}
