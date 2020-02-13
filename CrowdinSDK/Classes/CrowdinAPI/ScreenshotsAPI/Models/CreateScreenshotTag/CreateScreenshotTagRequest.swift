//
//  CreateScreenshotTagRequest.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 5/9/19.
//

import Foundation

public typealias CreateScreenshotTagRequest = [CreateScreenshotTagRequestElement]

public struct CreateScreenshotTagRequestElement: Codable {
    public let stringId: Int
    public let position: CreateScreenshotTagPosition
    
    enum CodingKeys: String, CodingKey {
        case stringId
        case position
    }
}

public struct CreateScreenshotTagPosition: Codable {
    public let x, y, width, height: Int
}
