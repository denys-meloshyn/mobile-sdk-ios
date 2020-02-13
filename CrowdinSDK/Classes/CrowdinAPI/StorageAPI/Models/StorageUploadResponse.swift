//
//  StorageUploadResponse.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 5/9/19.
//

import Foundation

public struct StorageUploadResponse: Codable {
    public let data: StorageUploadData
}

public struct StorageUploadData: Codable {
    public let id: Int
}
