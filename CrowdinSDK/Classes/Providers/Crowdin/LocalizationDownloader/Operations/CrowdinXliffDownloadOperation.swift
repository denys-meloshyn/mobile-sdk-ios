//
//  CrowdinXliffDownloadOperation.swift
//  BaseAPI
//
//  Created by Serhii Londar on 12.04.2020.
//

import Foundation

typealias CrowdinXliffDownloadOperationCompletion = ([String: String]?, [AnyHashable: Any]?, Error?) -> Void

class CrowdinXliffDownloadOperation: CrowdinDownloadOperation {
    var completion: CrowdinXliffDownloadOperationCompletion? = nil
    var strings: [String: String]?
    var plurals: [AnyHashable: Any]?
    var error: Error?
    var timestamp: TimeInterval?
    
    init(filePath: String, localization: String, timestamp: TimeInterval?, contentDeliveryAPI: CrowdinContentDeliveryAPI, completion: CrowdinXliffDownloadOperationCompletion?) {
        self.timestamp = timestamp
        super.init(filePath: CrowdinPathsParser.shared.parse(filePath, localization: localization), contentDeliveryAPI: contentDeliveryAPI)
        self.completion = completion
    }
    
    required init(filePath: String, localization: String, timestamp: TimeInterval?, contentDeliveryAPI: CrowdinContentDeliveryAPI) {
        self.timestamp = timestamp
        super.init(filePath: CrowdinPathsParser.shared.parse(filePath, localization: localization), contentDeliveryAPI: contentDeliveryAPI)
    }
    
    override func main() {
        let etag = ETagStorage.shared.etags[self.filePath]
        contentDeliveryAPI.getXliff(filePath: filePath, etag: etag, timestamp: timestamp) { [weak self] (xliffDict, etag, error) in
            guard let self = self else { return }
            var strings = [String: String]()
            var plurals = [AnyHashable: Any]()
            if let xliff = xliffDict?["xliff"] as? [AnyHashable: Any], let files = xliff["file"] as? [[AnyHashable: Any]] {
                for file in files {
                    if let attributes = file["XMLParserAttributesKey"] as? [String: String], let original = attributes["original"] {
                        if original.isStrings { // Parse strings
                            if let body = file["body"] as? [AnyHashable: Any], let transUnits = body["trans-unit"] as? [[String: Any]] {
                                for transUnit in transUnits {
                                    if let attributes = transUnit["XMLParserAttributesKey"] as? [String: String], let id = attributes["id"], let source = transUnit["source"] as? String {
                                        strings[id] = source
                                    }
                                }
                            }
                        } else if original.isStringsDict { // Parse Plurals
                            if let body = file["body"] as? [AnyHashable: Any], let transUnits = body["trans-unit"] as? [[String: Any]] {
                                for transUnit in transUnits {
                                    if let attributes = transUnit["XMLParserAttributesKey"] as? [String: String], let id = attributes["id"], let source = transUnit["source"] as? String {
                                        var path = id.split(separator: "/").map({ String($0) }).map({ $0.split(separator: ":").map({ String($0) }) })
                                        if path.count > 1 {
                                            path.removeLast()
                                            path[path.count - 1][1] = "string"
                                        }
                                        var currentDict = [AnyHashable: Any]()
                                        for index in (0..<path.count).reversed() {
                                            let currentPath = path[index]
                                            if currentPath.count == 2, currentPath[1] == "dict" {
                                                let key = currentPath[0]
                                                currentDict = [key: currentDict]
                                            } else if currentPath.count == 2, currentPath[1] == "string" {
                                                let key = currentPath[0]
                                                currentDict[key] = source
                                            }
                                        }
                                        plurals = plurals.merge(right: currentDict)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            ETagStorage.shared.etags[self.filePath] = etag
            self.strings = strings
            self.plurals = plurals
            self.error = error
            self.completion?(self.strings, self.plurals, self.error)
            self.finish(with: error != nil)
        }
    }
}