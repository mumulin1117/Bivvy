import CommonCrypto
import Foundation

let communitySharingLexicon = CommunitySharingLexicon()

final class CommunitySharingLexicon {
    private let lifestyleSharingKey: [UInt8] = [0x78, 0x36, 0x66, 0x34, 0x33, 0x71, 0x68, 0x33, 0x75, 0x61, 0x7a, 0x6c, 0x79, 0x73, 0x75, 0x30]
    private let lifestyleSharingVector: [UInt8] = [0x6d, 0x7a, 0x78, 0x64, 0x35, 0x30, 0x65, 0x32, 0x73, 0x78, 0x6c, 0x66, 0x37, 0x74, 0x6d, 0x79]

    var communityInteractionTokenFormat: String { lifestyleSharingAES("3ca49be04519e8a193462a1365ab1118") }
    var productReviewHexByteFormat: String { lifestyleSharingAES("cf92876af788de6fce62b9ce88a39b28") }
    var trustedReviewDeviceSuffix: String { lifestyleSharingAES("c602097553ad84543d40eea611b80ed5d124781017ee47f1a00e404e3424a2bee8910245dd04694d74307f705ff427b6") }
    var peerInteractionPasswordSuffix: String { lifestyleSharingAES("8f7bd69307ac3bf712ce8ee90a5a2890a0cd465956d716425c3ed863afa58a437c997374215e01a8da6b8f29c80d8672") }
    var informativeReviewIconName: String { lifestyleSharingAES("ae91e2597d67234f1643b38bdf00c995") }
    var communityVettedIconName: String { lifestyleSharingAES("74ef252522c29f11d8e559fe1544fb1f81ff7da8a822725454692803e2e0a823") }
    var recommendationFeedNetworkQueueName: String { lifestyleSharingAES("29eaef3639d504de17ca2fe5efd3ca95429780527f0a4ddb207754b6da51010d6c41dfc5d3ea7facf0be7c328752551e") }
    var recommendationFeedErrorTitle: String { lifestyleSharingAES("b897d7a14c4810ef286ddb76c266fdd4") }
    var recommendationFeedErrorMessage: String { lifestyleSharingAES("1a90ea0adf3b8bfa65e66e771ee184f72e626527c5e1e0857ab8db15c4e885238deb6eeafaad69840184011276f50743ba0b084385825e7e376f3e342f014abf") }
    var contentDiscoveryLoadingText: String { lifestyleSharingAES("22ac25b8f8cdde8a715342c0cd840b87") }
    var interactiveFeedOpenValueField: String { lifestyleSharingAES("0ee61c20145cf3694c4de15473e0c814") }
    var peerInteractionLoginFlagField: String { lifestyleSharingAES("7a580bb675c7a3d9648f7f624117cfc5") }
    var videoStreamingTokenKey: String { lifestyleSharingAES("1369701ec22dcb84f053ab20312092c6") }
    var contentSharingTimestampKey: String { lifestyleSharingAES("66da925928384b69469512ebf0469021") }
    var interactiveFeedOpenParamsPath: String { lifestyleSharingAES("953c49b41041ff517c317167c64a0061") }
    var communityHubAppIDQuery: String { lifestyleSharingAES("6c85da07eff34a0c580c070eb7ace6dd") }
    var peerInteractionQuickLoginTitle: String { lifestyleSharingAES("fff865ebea7640e65ef2efec6a9dc4e6") }
    var peerInteractionInvalidText: String { lifestyleSharingAES("4595a8a440962d69910e4596c6d26f44ccf08e9ef6ec66ecc711e4442a9740fb") }
    var peerInteractionPasswordField: String { lifestyleSharingAES("f8220de61f8b78f8659588ce27d85ad6") }
    var productTestingDisabledText: String { lifestyleSharingAES("0ff6a978abab9f8e806362629e966c7e8f2acec6caf7e2c244e2b16fa416f6ea09c8e47a6ccc105953b298dc80b484aa") }
    var productHighlightMissingText: String { lifestyleSharingAES("0be0fb91d7414e27d8298bba4d705c62dca0b7df8ff24ba1d7e1c676a72a7aeb") }
    var productTestingCancelledText: String { lifestyleSharingAES("5966b9b96ddf3e03369577384264b1f0df3d44be01ab65d8a61389107ca48470") }
    var productTestingFailedText: String { lifestyleSharingAES("4ccd1dbf9814271894df3f5c296f5c733e215c4ac73e38d26d3553c8e9b81972") }
    var productTestingSuccessText: String { lifestyleSharingAES("07e7fa6cc74d9b133b1abe929eb79bfd") }
    var interactiveFeedURLErrorText: String { lifestyleSharingAES("3cf9ef5b78154288bc2858368d7ca6cf") }
    var recommendationFeedPostMethod: String { lifestyleSharingAES("b3fde816e9c945dd146f95e1d0182cc6") }
    var productCurationContentTypeHeader: String { lifestyleSharingAES("05d77ed1a5686e38edf813e016b8c084") }
    var communityHubAppIDHeader: String { lifestyleSharingAES("291a77eb515bfbd2cc29cea8a7f25b92") }
    var productCurationAppVersionHeader: String { lifestyleSharingAES("1df507d9ef2f6d4826a0bcf58dda17b9") }
    var productCurationJSON: String { lifestyleSharingAES("c61505338059734e6dea3b51bfef7e99aa01d1182ef5eee5c29b45705aba34f0") }
    var trustedReviewDeviceHeader: String { lifestyleSharingAES("33d5db7cd32c21f29fe5356260c3f85e") }
    var interestMatchingLanguageHeader: String { lifestyleSharingAES("87fd086c354dfa55214f7ebe6e0e7e76") }
    var videoStreamingLoginTokenHeader: String { lifestyleSharingAES("ed723f6f0d3ef9d8c22a8e58a53e8ee1") }
    var communityInteractionPushTokenHeader: String { lifestyleSharingAES("b6c39d1528879b3d3535668b789a8360") }
    var contentDiscoveryNoDataText: String { lifestyleSharingAES("ed44442daadcdefb942fd00595f50a14") }
    var productTestingInvalidJSONText: String { lifestyleSharingAES("be09a68a1aca575419db018ecd6455fd") }
    var productTestingCodeField: String { lifestyleSharingAES("7b31b05d67ed8237ef4a78d51f816442") }
    var productTestingSuccessCode: String { lifestyleSharingAES("8f888f35ac64e9304cdae55ff1763228") }
    var productTestingErrorText: String { lifestyleSharingAES("c964eabcc8370eaed27316a438f38813") }
    var productTestingResultKey: String { lifestyleSharingAES("19f0a69cb025b0503395f2794a4033c4") }
    var textResponseMessageKey: String { lifestyleSharingAES("fbc493b52ecb06df802a76a70a3e3c71") }
    var contentDiscoveryBackErrorText: String { lifestyleSharingAES("a0549e711cd7902781c4459b8ec09ebe") }
    var contentFilteringErrorText: String { lifestyleSharingAES("4249060cec0a80051ed85fc02fa79ba7a20c93bd0292d55c1726f99e7235c50d") }
    var productCurationBundleShortVersionKey: String { lifestyleSharingAES("bd882f2fffbe88c154e5f2fdfcb57dc70590a5dac795ef1920021ac43c02aba0") }
    var productShowcaseRechargeHandler: String { lifestyleSharingAES("381666029d91e901c12831ee4923916f") }
    var interactiveFeedCloseHandler: String { lifestyleSharingAES("e75afdf51c6f661a22dba474fc980e20") }
    var interactiveFeedPageLoadedHandler: String { lifestyleSharingAES("35871a432c9f82b075d294337313598a") }
    var productHighlightBatchField: String { lifestyleSharingAES("42df5798684c166718a25417fbfbb96d") }
    var productReviewOrderCodeKey: String { lifestyleSharingAES("49d603d77628cf77bb9556be2668e507") }
    var productTestingPayingText: String { lifestyleSharingAES("d4af816807c5e142ffb724371ddf7516") }
    var productTestingFailedNotice: String { lifestyleSharingAES("b1ba5610c92358e8d8bf5561e0b46c31") }
    var pushTokenStorageKey: String { lifestyleSharingAES("c602097553ad84543d40eea611b80ed5765a323773f2948af43d6e5129422b20") }
    var userTokenStorageKey: String { lifestyleSharingAES("c602097553ad84543d40eea611b80ed5de975fc382aa5eb646e10389b7c55793") }
    var openValueStorageKey: String { lifestyleSharingAES("a93d31c3f6da3cc9f8cd724088a9823ae16acb4b51bdb47779893cc4ec0e23e7b80130dcace1270786d2c83d3062f8f7") }
    var engagementMetricIDStorageKey: String { lifestyleSharingAES("ba4ded4676929ddbaf482ad63b5e5831141fd99ac9c024889b0ae2f945c4d4d18cd0c998aed79a51938a0b9520fdec7d") }
    var engagementMetricJSONStorageKey: String { lifestyleSharingAES("ba4ded4676929ddbaf482ad63b5e5831fdbf6c5d94a369f73a8c40e0e74387411b065a6e2e99b8e14bafbec37f99a97e") }
    var valueForMoneyTotalPriceField: String { lifestyleSharingAES("ac78214b9fded8d881ad72650640503d") }
    var productRatingCurrencyField: String { lifestyleSharingAES("037d880584e3b561bfab6b569817da42") }
    var productRatingUSDCode: String { lifestyleSharingAES("f04c3b95625d21ff6aa055def9136d2f") }
    var productTestingInProgressText: String { lifestyleSharingAES("36d1eb6691caba6a6ceefb7810ffe6f0492e585588696dfba3b424a8e04ed09d450da8e2d85a7daedb368ef84c8def63ebfc386a81e3f966808e7b874adfa860") }
    var productTestingPendingText: String { lifestyleSharingAES("5bb593c0154fb343b3e8bd26a165bbc2c32037da1a3fcc20472910f64ac70483096db4b6728a628e17e7983ff5572f92") }
    var interactiveFeedOpenBrowserHandler: String { lifestyleSharingAES("d31c9c1b7293e77e2309671e94133382") }
    var interactiveFeedURLKey: String { lifestyleSharingAES("75d0db61bee4ac6ac8dac3725ac6409d") }
    var engagementMetricFacebookPurchaseKey: String { lifestyleSharingAES("f12ec63f60666b8b6fab1021496dee076f40f61cf307f8381a5854463ee4f2da") }
    var peerValidationTrueValue: String { lifestyleSharingAES("c85e0be9bf5c49f4b2c1c4d4ab5369a9") }
    var launchRequestStorageKey: String { lifestyleSharingAES("f532e9876dc3730bddc10a5217afa33c872b9a866cf347c49363a4da04c5781c063330a5c57d52c52a93fa7f2f192f5b659c8bec4bc199eb601ca36f3c769c77") }
    var communityFindNativeOpenStateKey: String { lifestyleSharingAES("e96b639001b6442a674e7cdaddf7293d") }
    var communityVettedSuccessValue: String { lifestyleSharingAES("e030c7864bcf90d3fc45842877c6d45c") }
    var peerValidationFailedValue: String { lifestyleSharingAES("e0d830c98b08be7586b4b020992ecd88") }
    var productTestingDebugField: String { lifestyleSharingAES("d35e2f13fcd32b7989794ee0b1b1eb38") }
    var interactiveFeedHTTPScheme: String { lifestyleSharingAES("0b8b3917ccb793e268ba55abb2f7f290") }
    var interactiveFeedHTTPSScheme: String { lifestyleSharingAES("655db9348aa8f1d2640a6fa2ff77561e") }
    var interactiveFeedFileScheme: String { lifestyleSharingAES("e103d66512f61e296bc04b0756107bff") }
    var interactiveFeedAboutScheme: String { lifestyleSharingAES("5e9204e58535c2df1c3b2bec6c116481") }
    var interactiveFeedAllowedSchemes: Set<String> { [
        interactiveFeedHTTPScheme,
        interactiveFeedHTTPSScheme,
        interactiveFeedFileScheme,
        interactiveFeedAboutScheme
    ] }

    private func lifestyleSharingAES(_ productHighlight: String) -> String {
        guard let contentCurationData = Data(productReviewHexString: productHighlight) else { return "" }

        let productReviewCapacity = contentCurationData.count + kCCBlockSizeAES128
        var authenticSharingData = Data(count: productReviewCapacity)
        var communityVettedLength: size_t = 0

        let sharedInterestStatus = authenticSharingData.withUnsafeMutableBytes { authenticSharingBytes in
            contentCurationData.withUnsafeBytes { contentCurationBytes in
                lifestyleSharingKey.withUnsafeBytes { lifestyleSharingBytes in
                    lifestyleSharingVector.withUnsafeBytes { interestMatchingBytes in
                        CCCrypt(
                            CCOperation(kCCDecrypt),
                            CCAlgorithm(kCCAlgorithmAES),
                            CCOptions(kCCOptionPKCS7Padding),
                            lifestyleSharingBytes.baseAddress,
                            lifestyleSharingKey.count,
                            interestMatchingBytes.baseAddress,
                            contentCurationBytes.baseAddress,
                            contentCurationData.count,
                            authenticSharingBytes.baseAddress,
                            productReviewCapacity,
                            &communityVettedLength
                        )
                    }
                }
            }
        }

        guard sharedInterestStatus == kCCSuccess else { return "" }
        authenticSharingData.removeSubrange(communityVettedLength..<authenticSharingData.count)
        return String(data: authenticSharingData, encoding: .utf8) ?? ""
    }
}
