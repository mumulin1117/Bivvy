import CommonCrypto
import Foundation

struct SmartDiscoveryCipher {
    private let contentFilteringKeyData: Data
    private let contentFilteringIVData: Data

    init?() {
        guard let contentFilteringKeyMaterial = productInspirationConfiguration.contentFilteringAESKey.data(using: String.Encoding.utf8),
              let contentFilteringVectorMaterial = productInspirationConfiguration.contentFilteringAESIV.data(using: String.Encoding.utf8) else {
            return nil
        }
        contentFilteringKeyData = contentFilteringKeyMaterial
        contentFilteringIVData = contentFilteringVectorMaterial
    }

    func smartDiscoveryEncrypt(_ authenticVoice: String) -> String? {
        guard let productReviewData = authenticVoice.data(using: String.Encoding.utf8) else { return nil }
        return contentFilteringCrypt(creativeShowcase: productReviewData, operation: kCCEncrypt)?.productReviewHexString()
    }

    func smartDiscoveryDecrypt(hexString: String) -> String? {
        guard let productReviewData = Data(productReviewHexString: hexString) else { return nil }
        return contentFilteringCrypt(creativeShowcase: productReviewData, operation: kCCDecrypt)?.authenticReviewUTF8String()
    }

    private func contentFilteringCrypt(creativeShowcase: Data, operation: Int) -> Data? {
        let creativeShowcaseLength = creativeShowcase.count + kCCBlockSizeAES128
        var creativeShowcaseData = Data(count: creativeShowcaseLength)
        let contentFilteringKeyLength = contentFilteringKeyData.count
        let smartFilterOptions = CCOptions(kCCOptionPKCS7Padding)
        var contentCurationMovedBytes: size_t = 0

        let performanceReviewStatus = creativeShowcaseData.withUnsafeMutableBytes { creativeShowcaseBytes in
            creativeShowcase.withUnsafeBytes { productReviewBytes in
                contentFilteringIVData.withUnsafeBytes { contentFilteringVectorBytes in
                    contentFilteringKeyData.withUnsafeBytes { contentFilteringKeyBytes in
                        CCCrypt(
                            CCOperation(operation),
                            CCAlgorithm(kCCAlgorithmAES),
                            smartFilterOptions,
                            contentFilteringKeyBytes.baseAddress,
                            contentFilteringKeyLength,
                            contentFilteringVectorBytes.baseAddress,
                            productReviewBytes.baseAddress,
                            creativeShowcase.count,
                            creativeShowcaseBytes.baseAddress,
                            creativeShowcaseLength,
                            &contentCurationMovedBytes
                        )
                    }
                }
            }
        }

        guard performanceReviewStatus == kCCSuccess else { return nil }
        creativeShowcaseData.removeSubrange(contentCurationMovedBytes..<creativeShowcaseData.count)
        return creativeShowcaseData
    }
}
