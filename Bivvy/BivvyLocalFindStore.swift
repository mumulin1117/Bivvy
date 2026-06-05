import UIKit

final class ProductShowcaseLocalFindStore {
    static let communityMarket = ProductShowcaseLocalFindStore()

    private let productShowcaseStorageKey = "bivvy_local_find_items"
    private let savedItemStorageKey = "bivvy_saved_product_showcase_ids"
    private let communityMarketDefaults = UserDefaults.standard

    private init() {}

    var productShowcaseItems: [ProductShowcaseFindItem] {
        loadUserProductShowcases() + BivvyMockContent.finds
    }

    func addProductShowcase(
        productHighlightTitle: String,
        communityMarketPrice: String,
        excellentConditionGrade: String,
        communityMarketCity: String,
        itemExchangeDemand: String,
        productCategoryName: String,
        productShowcaseImageName: String = "bivvy_find_card_daily",
        productWalkthroughImageNames: [String]? = nil
    ) {
        var userProductShowcases = loadUserProductShowcases()
        let productShowcaseItem = ProductShowcaseFindItem(
            productShowcaseId: UUID().uuidString,
            productHighlightTitle: productHighlightTitle,
            productCategorySubtitle: productCategoryName,
            productShowcaseImageName: productShowcaseImageName,
            engagementMetricLikes: "0",
            savedItemCount: "0",
            detailedReviewText: itemExchangeDemand,
            contentCreatorName: "You",
            dailyFindCreatedAt: "Just now",
            communityMarketPrice: communityMarketPrice,
            excellentConditionGrade: excellentConditionGrade,
            communityMarketCity: communityMarketCity,
            itemExchangeDemand: itemExchangeDemand,
            productCategoryName: productCategoryName,
            productWalkthroughImageNames: productWalkthroughImageNames ?? [productShowcaseImageName]
        )
        userProductShowcases.insert(productShowcaseItem, at: 0)
        saveUserProductShowcases(userProductShowcases)
    }

    func saveProductShowcaseImage(_ image: UIImage) -> String? {
        let productShowcaseDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("bivvy_uploaded_finds", isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: productShowcaseDirectory, withIntermediateDirectories: true)
            let productShowcaseFileURL = productShowcaseDirectory.appendingPathComponent("\(UUID().uuidString).jpg")
            guard let productShowcaseImageData = image.jpegData(compressionQuality: 0.84) else { return nil }
            try productShowcaseImageData.write(to: productShowcaseFileURL, options: .atomic)
            return productShowcaseFileURL.path
        } catch {
            return nil
        }
    }

    func isSavedItem(productShowcaseId: String) -> Bool {
        savedItemIds.contains(productShowcaseId)
    }

    @discardableResult
    func toggleSavedItem(productShowcaseId: String) -> Bool {
        var favoriteFindIds = savedItemIds
        if favoriteFindIds.contains(productShowcaseId) {
            favoriteFindIds.remove(productShowcaseId)
        } else {
            favoriteFindIds.insert(productShowcaseId)
        }
        communityMarketDefaults.set(Array(favoriteFindIds), forKey: savedItemStorageKey)
        return favoriteFindIds.contains(productShowcaseId)
    }

    private func loadUserProductShowcases() -> [ProductShowcaseFindItem] {
        guard let productShowcaseData = communityMarketDefaults.data(forKey: productShowcaseStorageKey) else { return [] }
        return (try? JSONDecoder().decode([ProductShowcaseFindItem].self, from: productShowcaseData)) ?? []
    }

    private func saveUserProductShowcases(_ productShowcaseItems: [ProductShowcaseFindItem]) {
        let productShowcaseData = try? JSONEncoder().encode(productShowcaseItems)
        communityMarketDefaults.set(productShowcaseData, forKey: productShowcaseStorageKey)
    }

    private var savedItemIds: Set<String> {
        Set(communityMarketDefaults.stringArray(forKey: savedItemStorageKey) ?? [])
    }
}

typealias BivvyLocalFindStore = ProductShowcaseLocalFindStore
