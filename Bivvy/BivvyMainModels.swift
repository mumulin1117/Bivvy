import UIKit

struct ProductShowcaseFindItem: Codable, Equatable {
    let productShowcaseId: String
    let productHighlightTitle: String
    let productCategorySubtitle: String
    let productShowcaseImageName: String
    let engagementMetricLikes: String
    let savedItemCount: String
    let detailedReviewText: String
    let contentCreatorName: String
    let dailyFindCreatedAt: String
    let communityMarketPrice: String?
    let excellentConditionGrade: String?
    let communityMarketCity: String?
    let itemExchangeDemand: String?
    let productCategoryName: String?
    let productWalkthroughImageNames: [String]?

    enum CodingKeys: String, CodingKey {
        case productShowcaseId = "id"
        case productHighlightTitle = "title"
        case productCategorySubtitle = "subtitle"
        case productShowcaseImageName = "imageName"
        case engagementMetricLikes = "likes"
        case savedItemCount = "saves"
        case detailedReviewText = "detail"
        case contentCreatorName = "authorName"
        case dailyFindCreatedAt = "createdAt"
        case communityMarketPrice = "price"
        case excellentConditionGrade = "qualityGrade"
        case communityMarketCity = "city"
        case itemExchangeDemand = "exchangeDemand"
        case productCategoryName = "category"
        case productWalkthroughImageNames = "detailImageNames"
    }
}

typealias BivvyFindItem = ProductShowcaseFindItem

extension UIImage {
    static func bivvyFindImage(namedOrPath value: String) -> UIImage? {
        if let bundledImage = UIImage(named: value) {
            return bundledImage
        }
        return UIImage(contentsOfFile: value)
    }
}

struct ProductCategoryExplorationItem {
    let productHighlightTitle: String
    let detailedReviewText: String
    let color: UIColor
}

typealias BivvyCategoryItem = ProductCategoryExplorationItem

struct VideoDiscoverySnippetItem {
    let productShowcaseId: String
    let userDiscoveryId: String
    let productCategoryName: String
    let contentCreatorName: String
    let authenticReviewDescription: String
    let videoSnippetCoverImageName: String
    let videoStreamingCoverURL: String?
    let contentCreatorAvatarURL: String?
    let engagementMetricLikes: String
    let savedItemCount: String
    let discussionStarterComments: String
    let videoEngagementIsLiked: Bool
}

typealias BivvyVideoItem = VideoDiscoverySnippetItem

struct ContentCreatorProfileItem {
    let productShowcaseImageName: String
    let productShowcaseImageURL: String?
    let productHighlightTitle: String
    let handpickedDynamicId: String?
}

typealias BivvyProfileItem = ContentCreatorProfileItem

struct UserRecommendationProfile {
    let productShowcaseId: String
    let contentCreatorName: String
    let contentCreatorAvatarName: String
    let contentCreatorAvatarURL: String?
    let conversationStarterBrief: String
}

typealias BivvyRecommendationUser = UserRecommendationProfile

enum BivvyMockContent {
    static let categories: [ProductCategoryExplorationItem] = [
        ProductCategoryExplorationItem(productHighlightTitle: "Trendy toys", detailedReviewText: "popular finds", color: UIColor(red: 255 / 255, green: 224 / 255, blue: 242 / 255, alpha: 1)),
        ProductCategoryExplorationItem(productHighlightTitle: "Apparel", detailedReviewText: "style picks", color: UIColor(red: 231 / 255, green: 226 / 255, blue: 255 / 255, alpha: 1)),
        ProductCategoryExplorationItem(productHighlightTitle: "Figurines", detailedReviewText: "collector picks", color: UIColor(red: 223 / 255, green: 245 / 255, blue: 255 / 255, alpha: 1)),
        ProductCategoryExplorationItem(productHighlightTitle: "Digital", detailedReviewText: "smart finds", color: UIColor(red: 255 / 255, green: 236 / 255, blue: 212 / 255, alpha: 1))
    ]

    static let finds: [ProductShowcaseFindItem] = [
        ProductShowcaseFindItem(productShowcaseId: "local-everyday-backpack", productHighlightTitle: "Everyday Backpack", productCategorySubtitle: "Apparel", productShowcaseImageName: "bivvy_find_local_10004_main", engagementMetricLikes: "1.1k", savedItemCount: "286", detailedReviewText: "A practical everydayDiscovery backpack for commuting, short trips, and casual daily routines.", contentCreatorName: "Howard Ramos", dailyFindCreatedAt: "Today", communityMarketPrice: "$28", excellentConditionGrade: "Gently Used", communityMarketCity: "Los Angeles", itemExchangeDemand: "Open to exchanging for small lifestyle items or accessories.", productCategoryName: "Apparel", productWalkthroughImageNames: ["bivvy_find_local_10004_main"]),
        ProductShowcaseFindItem(productShowcaseId: "local-wireless-speaker", productHighlightTitle: "Wireless Speaker", productCategorySubtitle: "Digital", productShowcaseImageName: "bivvy_find_local_10005_main", engagementMetricLikes: "928", savedItemCount: "231", detailedReviewText: "A compact smartGadget pick for desk music, home organization days, and small gatherings.", contentCreatorName: "Mira Lane", dailyFindCreatedAt: "Today", communityMarketPrice: "$35", excellentConditionGrade: "Excellent", communityMarketCity: "New York", itemExchangeDemand: "Interested in useful desk items or similar gadgets.", productCategoryName: "Digital", productWalkthroughImageNames: ["bivvy_find_local_10005_main", "bivvy_find_local_10005_detail_01"]),
        ProductShowcaseFindItem(productShowcaseId: "local-ceramic-coffee-mug-set", productHighlightTitle: "Ceramic Coffee Mug Set", productCategorySubtitle: "Trendy toys", productShowcaseImageName: "bivvy_find_local_10006_main", engagementMetricLikes: "812", savedItemCount: "204", detailedReviewText: "A cozy homeGood set for coffeeLover routines and small kitchen styling.", contentCreatorName: "Cole Avery", dailyFindCreatedAt: "Yesterday", communityMarketPrice: "$18", excellentConditionGrade: "Like New", communityMarketCity: "London", itemExchangeDemand: "Looking for home decor items or kitchen accessories.", productCategoryName: "Trendy toys", productWalkthroughImageNames: ["bivvy_find_local_10006_main"]),
        ProductShowcaseFindItem(productShowcaseId: "local-travel-organizer-bag", productHighlightTitle: "Travel Organizer Bag", productCategorySubtitle: "Apparel", productShowcaseImageName: "bivvy_find_local_10007_main", engagementMetricLikes: "1.6k", savedItemCount: "410", detailedReviewText: "A usefulFind for packingHack workflows and weekend travel gear.", contentCreatorName: "Nora Quinn", dailyFindCreatedAt: "Yesterday", communityMarketPrice: "$22", excellentConditionGrade: "Very Good", communityMarketCity: "Paris", itemExchangeDemand: "Open to travel-related items in similar condition.", productCategoryName: "Apparel", productWalkthroughImageNames: ["bivvy_find_local_10007_main", "bivvy_find_local_10007_detail_01"]),
        ProductShowcaseFindItem(productShowcaseId: "local-portable-desk-lamp", productHighlightTitle: "Portable Desk Lamp", productCategorySubtitle: "Digital", productShowcaseImageName: "bivvy_find_local_10009_main", engagementMetricLikes: "734", savedItemCount: "188", detailedReviewText: "A routineEnhancer desk lamp for study corners, contentCreationGear setups, and late reading.", contentCreatorName: "June Park", dailyFindCreatedAt: "Jun 03", communityMarketPrice: "$30", excellentConditionGrade: "Excellent", communityMarketCity: "Berlin", itemExchangeDemand: "Interested in office accessories or storage solutions.", productCategoryName: "Digital", productWalkthroughImageNames: ["bivvy_find_local_10009_main", "bivvy_find_local_10009_detail_01"]),
        ProductShowcaseFindItem(productShowcaseId: "local-reusable-water-bottle", productHighlightTitle: "Reusable Water Bottle", productCategorySubtitle: "Trendy toys", productShowcaseImageName: "bivvy_find_local_10010_main", engagementMetricLikes: "689", savedItemCount: "166", detailedReviewText: "A sustainableChoice bottle for fitnessGear days, outdoorFind plans, and mindfulConsumption.", contentCreatorName: "Ari Stone", dailyFindCreatedAt: "Jun 03", communityMarketPrice: "$12", excellentConditionGrade: "Good", communityMarketCity: "Toronto", itemExchangeDemand: "Looking for fitness or outdoor accessories.", productCategoryName: "Trendy toys", productWalkthroughImageNames: ["bivvy_find_local_10010_main", "bivvy_find_local_10010_detail_01"]),
        ProductShowcaseFindItem(productShowcaseId: "local-bluetooth-keyboard", productHighlightTitle: "Bluetooth Keyboard", productCategorySubtitle: "Digital", productShowcaseImageName: "bivvy_find_local_10011_main", engagementMetricLikes: "2.3k", savedItemCount: "528", detailedReviewText: "A productivityTool keyboard for deskTour setups and focused writing sessions.", contentCreatorName: "Evan Reed", dailyFindCreatedAt: "Jun 02", communityMarketPrice: "$40", excellentConditionGrade: "Like New", communityMarketCity: "Amsterdam", itemExchangeDemand: "Open to exchanging for tech accessories or desk tools.", productCategoryName: "Digital", productWalkthroughImageNames: ["bivvy_find_local_10011_main"]),
        ProductShowcaseFindItem(productShowcaseId: "local-canvas-tote-bag", productHighlightTitle: "Canvas Tote Bag", productCategorySubtitle: "Apparel", productShowcaseImageName: "bivvy_find_local_10012_main", engagementMetricLikes: "571", savedItemCount: "143", detailedReviewText: "A capsuleWardrobe tote for errands, thriftFind days, and lightweight daily carry.", contentCreatorName: "Lina Wood", dailyFindCreatedAt: "Jun 02", communityMarketPrice: "$15", excellentConditionGrade: "Very Good", communityMarketCity: "Chicago", itemExchangeDemand: "Interested in casual lifestyle items or small accessories.", productCategoryName: "Apparel", productWalkthroughImageNames: ["bivvy_find_local_10012_main"]),
        ProductShowcaseFindItem(productShowcaseId: "local-reading-light", productHighlightTitle: "Reading Light", productCategorySubtitle: "Digital", productShowcaseImageName: "bivvy_find_local_10013_main", engagementMetricLikes: "649", savedItemCount: "152", detailedReviewText: "A compact readingList companion for study sessions and nightRoutine comfort.", contentCreatorName: "Tessa Moon", dailyFindCreatedAt: "Jun 01", communityMarketPrice: "$20", excellentConditionGrade: "Excellent", communityMarketCity: "Barcelona", itemExchangeDemand: "Looking for study or workspace essentials.", productCategoryName: "Digital", productWalkthroughImageNames: ["bivvy_find_local_10013_main"]),
        ProductShowcaseFindItem(productShowcaseId: "local-storage-basket-set", productHighlightTitle: "Storage Basket Set", productCategorySubtitle: "Trendy toys", productShowcaseImageName: "bivvy_find_local_10014_main", engagementMetricLikes: "1.4k", savedItemCount: "397", detailedReviewText: "A homeOrganization set for declutteringTip posts and clean shelf styling.", contentCreatorName: "Miles Hart", dailyFindCreatedAt: "Jun 01", communityMarketPrice: "$25", excellentConditionGrade: "Good", communityMarketCity: "Milan", itemExchangeDemand: "Open to exchanging for home organization items or decor pieces.", productCategoryName: "Trendy toys", productWalkthroughImageNames: ["bivvy_find_local_10014_main"]),
        ProductShowcaseFindItem(productShowcaseId: "local-collector-display", productHighlightTitle: "Collector Display Find", productCategorySubtitle: "Figurines", productShowcaseImageName: "bivvy_find_local_10015_main", engagementMetricLikes: "882", savedItemCount: "216", detailedReviewText: "A collectibleShowcase pick for shelf styling and nicheInterest communities.", contentCreatorName: "Mira Lane", dailyFindCreatedAt: "May 31", communityMarketPrice: "$32", excellentConditionGrade: "Excellent", communityMarketCity: "San Francisco", itemExchangeDemand: "Open to rareFind accessories or a small display stand.", productCategoryName: "Figurines", productWalkthroughImageNames: ["bivvy_find_local_10015_main"]),
        ProductShowcaseFindItem(productShowcaseId: "local-creative-desk-piece", productHighlightTitle: "Creative Desk Piece", productCategorySubtitle: "Figurines", productShowcaseImageName: "bivvy_find_local_10016_main", engagementMetricLikes: "745", savedItemCount: "190", detailedReviewText: "A small aestheticFind for workspaces, shelf decor, and productShowcase posts.", contentCreatorName: "Cole Avery", dailyFindCreatedAt: "May 31", communityMarketPrice: "$24", excellentConditionGrade: "Very Good", communityMarketCity: "Boston", itemExchangeDemand: "Interested in another desk item or mini collectible.", productCategoryName: "Figurines", productWalkthroughImageNames: ["bivvy_find_local_10016_main"]),
        ProductShowcaseFindItem(productShowcaseId: "local-handpicked-accessory", productHighlightTitle: "Handpicked Accessory", productCategorySubtitle: "Apparel", productShowcaseImageName: "bivvy_find_local_10017_main", engagementMetricLikes: "1.9k", savedItemCount: "464", detailedReviewText: "A stylish everydayHero accessory for outfitOfTheDay and lifestyleSharing posts.", contentCreatorName: "Nora Quinn", dailyFindCreatedAt: "May 30", communityMarketPrice: "$19", excellentConditionGrade: "Like New", communityMarketCity: "Portland", itemExchangeDemand: "Looking for a useful accessory in similar condition.", productCategoryName: "Apparel", productWalkthroughImageNames: ["bivvy_find_local_10017_main"])
    ]

    static let recommendationUsers: [UserRecommendationProfile] = []

    static let videos: [VideoDiscoverySnippetItem] = []

    static let profileGrid: [ContentCreatorProfileItem] = []
}
