//
//  TopSuggestionResponse.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 5/19/19.
//

import Foundation

public struct TopSuggestionResponse: Codable {
    public let event: String?
    public let data: TopSuggestionResponseData?
}

public struct TopSuggestionResponseData: Codable {
    public let id, userID, time, text: String?
    public let wordsCount: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case time, text
        case wordsCount = "words_count"
    }
}
