//
//  CrowdinProviderConfig.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 4/9/19.
//

import Foundation
import CrowdinSDK

@objcMembers public class CrowdinProviderConfig: NSObject {
    public var hashString: String
    public var localizations: [String]
    public var sourceLanguage: String
    
    public init(hashString: String, localizations: [String], sourceLanguage: String) {
        self.hashString = hashString
        self.localizations = localizations
        self.sourceLanguage = sourceLanguage
    }
    
    public override init() {
        guard let hashString = Bundle.main.crowdinDistributionHash else {
            fatalError("Please add CrowdinDistributionHash key to your Info.plist file")
        }
        self.hashString = hashString
        guard let localizations = Bundle.main.cw_localizations else {
            fatalError("Please add CrowdinLocalizations key to your Info.plist file")
        }
        self.localizations = localizations
        guard let crowdinSourceLanguage = Bundle.main.crowdinSourceLanguage else {
            fatalError("Please add CrowdinPluralsFileNames key to your Info.plist file")
        }
        self.sourceLanguage = crowdinSourceLanguage
    }
}
