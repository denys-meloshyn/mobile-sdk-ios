//
//  UpdateDraftResponse.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 5/19/19.
//

import Foundation

public struct UpdateDraftResponse: Codable {
    public let event: String?
    public let data: UpdateDraftResponseData?
}

public struct UpdateDraftResponseData: Codable {
    public let text, pluralForm: String?
}
