import UIKit

struct BivvyFindItem: Codable, Equatable {
    let id: String
    let title: String
    let subtitle: String
    let imageName: String
    let likes: String
    let saves: String
    let detail: String
    let authorName: String
    let createdAt: String
    let price: String?
    let qualityGrade: String?
    let city: String?
    let exchangeDemand: String?
    let category: String?
    let detailImageNames: [String]?
}

struct BivvyCategoryItem {
    let title: String
    let detail: String
    let color: UIColor
}

struct BivvyVideoItem {
    let id: String
    let category: String
    let userName: String
    let description: String
    let coverImageName: String
    let coverURL: String?
    let likes: String
    let saves: String
    let comments: String
    let isLiked: Bool
}

struct BivvyProfileItem {
    let imageName: String
    let imageURL: String?
    let title: String
    let dynamicId: String?
}

struct BivvyRecommendationUser {
    let id: String
    let name: String
    let avatarName: String
    let avatarURL: String?
    let brief: String
}

enum BivvyMockContent {
    static let categories: [BivvyCategoryItem] = [
        BivvyCategoryItem(title: "Trendy toys", detail: "popular finds", color: UIColor(red: 255 / 255, green: 224 / 255, blue: 242 / 255, alpha: 1)),
        BivvyCategoryItem(title: "Apparel", detail: "style picks", color: UIColor(red: 231 / 255, green: 226 / 255, blue: 255 / 255, alpha: 1)),
        BivvyCategoryItem(title: "Figurines", detail: "collector picks", color: UIColor(red: 223 / 255, green: 245 / 255, blue: 255 / 255, alpha: 1)),
        BivvyCategoryItem(title: "Digital", detail: "smart finds", color: UIColor(red: 255 / 255, green: 236 / 255, blue: 212 / 255, alpha: 1))
    ]

    static let finds: [BivvyFindItem] = [
        BivvyFindItem(id: "local-everyday-backpack", title: "Everyday Backpack", subtitle: "Apparel", imageName: "bivvy_find_local_10004_main", likes: "1.1k", saves: "286", detail: "A practical everydayDiscovery backpack for commuting, short trips, and casual daily routines.", authorName: "Howard Ramos", createdAt: "Today", price: "$28", qualityGrade: "Gently Used", city: "Los Angeles", exchangeDemand: "Open to exchanging for small lifestyle items or accessories.", category: "Apparel", detailImageNames: ["bivvy_find_local_10004_main"]),
        BivvyFindItem(id: "local-wireless-speaker", title: "Wireless Speaker", subtitle: "Digital", imageName: "bivvy_find_local_10005_main", likes: "928", saves: "231", detail: "A compact smartGadget pick for desk music, home organization days, and small gatherings.", authorName: "Mira Lane", createdAt: "Today", price: "$35", qualityGrade: "Excellent", city: "New York", exchangeDemand: "Interested in useful desk items or similar gadgets.", category: "Digital", detailImageNames: ["bivvy_find_local_10005_main", "bivvy_find_local_10005_detail_01"]),
        BivvyFindItem(id: "local-ceramic-coffee-mug-set", title: "Ceramic Coffee Mug Set", subtitle: "Trendy toys", imageName: "bivvy_find_local_10006_main", likes: "812", saves: "204", detail: "A cozy homeGood set for coffeeLover routines and small kitchen styling.", authorName: "Cole Avery", createdAt: "Yesterday", price: "$18", qualityGrade: "Like New", city: "London", exchangeDemand: "Looking for home decor items or kitchen accessories.", category: "Trendy toys", detailImageNames: ["bivvy_find_local_10006_main"]),
        BivvyFindItem(id: "local-travel-organizer-bag", title: "Travel Organizer Bag", subtitle: "Apparel", imageName: "bivvy_find_local_10007_main", likes: "1.6k", saves: "410", detail: "A usefulFind for packingHack workflows and weekend travel gear.", authorName: "Nora Quinn", createdAt: "Yesterday", price: "$22", qualityGrade: "Very Good", city: "Paris", exchangeDemand: "Open to travel-related items in similar condition.", category: "Apparel", detailImageNames: ["bivvy_find_local_10007_main", "bivvy_find_local_10007_detail_01"]),
        BivvyFindItem(id: "local-portable-desk-lamp", title: "Portable Desk Lamp", subtitle: "Digital", imageName: "bivvy_find_local_10009_main", likes: "734", saves: "188", detail: "A routineEnhancer desk lamp for study corners, contentCreationGear setups, and late reading.", authorName: "June Park", createdAt: "Jun 03", price: "$30", qualityGrade: "Excellent", city: "Berlin", exchangeDemand: "Interested in office accessories or storage solutions.", category: "Digital", detailImageNames: ["bivvy_find_local_10009_main", "bivvy_find_local_10009_detail_01"]),
        BivvyFindItem(id: "local-reusable-water-bottle", title: "Reusable Water Bottle", subtitle: "Trendy toys", imageName: "bivvy_find_local_10010_main", likes: "689", saves: "166", detail: "A sustainableChoice bottle for fitnessGear days, outdoorFind plans, and mindfulConsumption.", authorName: "Ari Stone", createdAt: "Jun 03", price: "$12", qualityGrade: "Good", city: "Toronto", exchangeDemand: "Looking for fitness or outdoor accessories.", category: "Trendy toys", detailImageNames: ["bivvy_find_local_10010_main", "bivvy_find_local_10010_detail_01"]),
        BivvyFindItem(id: "local-bluetooth-keyboard", title: "Bluetooth Keyboard", subtitle: "Digital", imageName: "bivvy_find_local_10011_main", likes: "2.3k", saves: "528", detail: "A productivityTool keyboard for deskTour setups and focused writing sessions.", authorName: "Evan Reed", createdAt: "Jun 02", price: "$40", qualityGrade: "Like New", city: "Amsterdam", exchangeDemand: "Open to exchanging for tech accessories or desk tools.", category: "Digital", detailImageNames: ["bivvy_find_local_10011_main"]),
        BivvyFindItem(id: "local-canvas-tote-bag", title: "Canvas Tote Bag", subtitle: "Apparel", imageName: "bivvy_find_local_10012_main", likes: "571", saves: "143", detail: "A capsuleWardrobe tote for errands, thriftFind days, and lightweight daily carry.", authorName: "Lina Wood", createdAt: "Jun 02", price: "$15", qualityGrade: "Very Good", city: "Chicago", exchangeDemand: "Interested in casual lifestyle items or small accessories.", category: "Apparel", detailImageNames: ["bivvy_find_local_10012_main"]),
        BivvyFindItem(id: "local-reading-light", title: "Reading Light", subtitle: "Digital", imageName: "bivvy_find_local_10013_main", likes: "649", saves: "152", detail: "A compact readingList companion for study sessions and nightRoutine comfort.", authorName: "Tessa Moon", createdAt: "Jun 01", price: "$20", qualityGrade: "Excellent", city: "Barcelona", exchangeDemand: "Looking for study or workspace essentials.", category: "Digital", detailImageNames: ["bivvy_find_local_10013_main"]),
        BivvyFindItem(id: "local-storage-basket-set", title: "Storage Basket Set", subtitle: "Trendy toys", imageName: "bivvy_find_local_10014_main", likes: "1.4k", saves: "397", detail: "A homeOrganization set for declutteringTip posts and clean shelf styling.", authorName: "Miles Hart", createdAt: "Jun 01", price: "$25", qualityGrade: "Good", city: "Milan", exchangeDemand: "Open to exchanging for home organization items or decor pieces.", category: "Trendy toys", detailImageNames: ["bivvy_find_local_10014_main"]),
        BivvyFindItem(id: "local-collector-display", title: "Collector Display Find", subtitle: "Figurines", imageName: "bivvy_find_local_10015_main", likes: "882", saves: "216", detail: "A collectibleShowcase pick for shelf styling and nicheInterest communities.", authorName: "Mira Lane", createdAt: "May 31", price: "$32", qualityGrade: "Excellent", city: "San Francisco", exchangeDemand: "Open to rareFind accessories or a small display stand.", category: "Figurines", detailImageNames: ["bivvy_find_local_10015_main"]),
        BivvyFindItem(id: "local-creative-desk-piece", title: "Creative Desk Piece", subtitle: "Figurines", imageName: "bivvy_find_local_10016_main", likes: "745", saves: "190", detail: "A small aestheticFind for workspaces, shelf decor, and productShowcase posts.", authorName: "Cole Avery", createdAt: "May 31", price: "$24", qualityGrade: "Very Good", city: "Boston", exchangeDemand: "Interested in another desk item or mini collectible.", category: "Figurines", detailImageNames: ["bivvy_find_local_10016_main"]),
        BivvyFindItem(id: "local-handpicked-accessory", title: "Handpicked Accessory", subtitle: "Apparel", imageName: "bivvy_find_local_10017_main", likes: "1.9k", saves: "464", detail: "A stylish everydayHero accessory for outfitOfTheDay and lifestyleSharing posts.", authorName: "Nora Quinn", createdAt: "May 30", price: "$19", qualityGrade: "Like New", city: "Portland", exchangeDemand: "Looking for a useful accessory in similar condition.", category: "Apparel", detailImageNames: ["bivvy_find_local_10017_main"])
    ]

    static let recommendationUsers: [BivvyRecommendationUser] = [
        BivvyRecommendationUser(id: "creator-howard", name: "Howard", avatarName: "bivvy_profile_avatar_main", avatarURL: nil, brief: "productDemo"),
        BivvyRecommendationUser(id: "creator-mira", name: "Mira", avatarName: "bivvy_auth_profile_avatar", avatarURL: nil, brief: "hiddenGem"),
        BivvyRecommendationUser(id: "creator-cole", name: "Cole", avatarName: "bivvy_profile_avatar_main", avatarURL: nil, brief: "homeGood")
    ]

    static let videos: [BivvyVideoItem] = [
        BivvyVideoItem(
            id: "video-anders-flower",
            category: "For you",
            userName: "Anders",
            description: "Can't believe I didn't get this sooner",
            coverImageName: "bivvy_video_cover_featured",
            coverURL: nil,
            likes: "23.8k",
            saves: "4.1k",
            comments: "862",
            isLiked: false
        ),
        BivvyVideoItem(
            id: "video-fun-desk-gadget",
            category: "Fun",
            userName: "Mira",
            description: "A tiny desk gadget that made my workspace feel cleaner.",
            coverImageName: "bivvy_find_local_10005_main",
            coverURL: nil,
            likes: "9.6k",
            saves: "1.8k",
            comments: "324",
            isLiked: false
        ),
        BivvyVideoItem(
            id: "video-friend-travel-bag",
            category: "Friend",
            userName: "Nora",
            description: "This organizer bag saved my weekend packing routine.",
            coverImageName: "bivvy_find_local_10007_main",
            coverURL: nil,
            likes: "12.4k",
            saves: "2.2k",
            comments: "491",
            isLiked: false
        ),
        BivvyVideoItem(
            id: "video-foryou-water-bottle",
            category: "For you",
            userName: "Ari",
            description: "Reusable bottle check for outdoor days and daily hydration.",
            coverImageName: "bivvy_find_local_10010_main",
            coverURL: nil,
            likes: "7.3k",
            saves: "980",
            comments: "215",
            isLiked: false
        ),
        BivvyVideoItem(
            id: "video-fun-keyboard",
            category: "Fun",
            userName: "Evan",
            description: "A compact keyboard that makes short reviews easier to write.",
            coverImageName: "bivvy_find_local_10011_main",
            coverURL: nil,
            likes: "18.1k",
            saves: "3.6k",
            comments: "738",
            isLiked: false
        )
    ]

    static let profileGrid: [BivvyProfileItem] = [
        BivvyProfileItem(imageName: "bivvy_profile_grid_find_one", imageURL: nil, title: "productShowcase", dynamicId: nil),
        BivvyProfileItem(imageName: "bivvy_profile_grid_find_two", imageURL: nil, title: "favoriteFind", dynamicId: nil),
        BivvyProfileItem(imageName: "bivvy_profile_grid_find_three", imageURL: nil, title: "communityFind", dynamicId: nil)
    ]
}
