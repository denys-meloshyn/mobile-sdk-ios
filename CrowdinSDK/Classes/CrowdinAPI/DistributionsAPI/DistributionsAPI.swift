//
//  DistributionsAPI.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 5/19/19.
//

import Foundation

public class DistributionsAPI: CrowdinAPI {
    let hashString: String
    
    public init(hashString: String, organizationName: String? = nil, auth: CrowdinAuth? = nil) {
        self.hashString = hashString
        super.init(organizationName: organizationName, auth: auth)
    }
	
	override var apiPath: String {
		return "distributions/metadata?hash=\(hashString)"
	}
	
    public func getDistribution(completion: @escaping (DistributionsResponse?, Error?) -> Void) {
        self.cw_get(url: fullPath, completion: completion)
    }
}
