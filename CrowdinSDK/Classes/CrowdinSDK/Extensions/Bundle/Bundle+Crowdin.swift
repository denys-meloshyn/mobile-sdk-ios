//
//  Bundle+Crowdin.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 3/19/19.
//

import Foundation

// MARK: - Extension for reading Crowdin SDK configuration values from Info.plist.
extension Bundle {
    /// Crowdin CDN hash value.
    public var crowdinDistributionHash: String? {
        return infoDictionary?["CrowdinDistributionHash"] as? String
    }
    
    /// Supported localizations for current application on crowdin server.
    public var cw_localizations: [String]? {
        return infoDictionary?["CrowdinLocalizations"] as? [String]
    }
    
    /// Source language for current project on crowdin server.
    public var crowdinSourceLanguage: String? {
        return infoDictionary?["CrowdinSourceLanguage"] as? String
    }
}
