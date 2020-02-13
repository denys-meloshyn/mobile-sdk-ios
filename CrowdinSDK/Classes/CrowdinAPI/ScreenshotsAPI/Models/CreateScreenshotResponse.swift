//
//  CreateScreenshotResponse.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 5/9/19.
//

import Foundation

public struct CreateScreenshotResponse: Codable {
    public let data: CreateScreenshotData
}

public struct CreateScreenshotData: Codable {
    public let id, userID: Int
    public let url, name: String
    public let size: CreateScreenshotSize
    public let tagsCount: Int
    public let tags: [CreateScreenshotTag]
    public let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case url, name, size, tagsCount, tags, createdAt, updatedAt
    }
}

public struct CreateScreenshotSize: Codable {
    public let width, height: Int
}

public struct CreateScreenshotTag: Codable {
    public let id, screenshotID, stringID: Int
    public let position: CreateScreenshotPosition
    public let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case screenshotID = "screenshotId"
        case stringID = "stringId"
        case position, createdAt
    }
}

public struct CreateScreenshotPosition: Codable {
    public let x, y, width, height: Int
}
