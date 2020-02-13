//
//  CreateScreenshotTagResponse.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 5/9/19.
//

import Foundation

public struct CreateScreenshotTagResponse: Codable {
    public let data: [CreateScreenshotTagDatum]
    public let pagination: CreateScreenshotTagPagination
}

public struct CreateScreenshotTagDatum: Codable {
    public let data: CreateScreenshotTagData
}

public struct CreateScreenshotTagData: Codable {
    public let id, screenshotId, stringId: Int
    public let position: CreateScreenshotTagPosition
    public let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case screenshotId
        case stringId
        case position, createdAt
    }
}

public struct CreateScreenshotTagPagination: Codable {
    public let offset, limit: Int
}
