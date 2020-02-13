//
//  Refreshable.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 3/5/19.
//

import Foundation

public protocol Refreshable: NSObjectProtocol {
    var key: String? { get }
    func refresh(text: String)
    func refresh()
}
