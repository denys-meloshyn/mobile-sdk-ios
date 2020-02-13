//
//  CrowdinSDK+IntervalUpdate.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 6/1/19.
//

import Foundation
import CrowdinSDK

extension CrowdinSDK {
    public class func startIntervalUpdates(interval: TimeInterval) {
        IntervalUpdateFeature.shared = IntervalUpdateFeature(interval: interval)
        IntervalUpdateFeature.shared?.start()
    }
    
    public class func stopIntervalUpdates() {
        IntervalUpdateFeature.shared?.stop()
        IntervalUpdateFeature.shared = nil
    }
    
    public class var intervalUpdatesEnabled: Bool {
        return IntervalUpdateFeature.shared?.enabled ?? false
    }
    
    class func initializeIntervalUpdateFeature() {
        guard let config = CrowdinSDK.config else { return }
        if config.intervalUpdatesEnabled {
            if let interval = config.localizationUpdatesInterval {
                IntervalUpdateFeature.shared = IntervalUpdateFeature(interval: interval)
            } else {
                IntervalUpdateFeature.shared = IntervalUpdateFeature()
            }
            IntervalUpdateFeature.shared?.start()
        }
    }
}
