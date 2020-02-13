//
//  File.swift
//  
//
//  Created by Serhii Londar on 13.02.2020.
//

import UIKit

extension UIButton: Refreshable {
    public func refresh(text: String) {
        if let values = self.localizationValues?[state.rawValue] as? [CVarArg] {
            let newText = String(format: text, arguments: values)
            self.original_setTitle(newText, for: self.state)
        } else {
            self.original_setTitle(text, for: self.state)
        }
    }
    
    public var key: String? {
        return self.localizationKeys?[state.rawValue]
    }
    
    public func refresh() {
        UIControl.State.all.forEach { (state) in
            guard let key = self.localizationKeys?[state.rawValue] else { return }
            if let values = self.localizationValues?[state.rawValue] as? [CVarArg] {
                self.setTitle(key.cw_localized(with: values), for: state)
            } else {
                self.setTitle(key.cw_localized, for: state)
            }
        }
    }
}
