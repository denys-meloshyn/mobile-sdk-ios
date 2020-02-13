//
//  File.swift
//  
//
//  Created by Serhii Londar on 13.02.2020.
//

import UIKit

extension UILabel: Refreshable {
    public func refresh(text: String) {
        if let values = self.localizationValues as? [CVarArg] {
            let newText = String(format: text, arguments: values)
            self.original_setText(newText)
        } else {
            self.original_setText(text)
        }
    }
    
    public var key: String? {
        return self.localizationKey
    }
    
    public func refresh() {
        guard let key = self.localizationKey else { return }
        if let values = self.localizationValues as? [CVarArg] {
            self.text = key.cw_localized(with: values)
        } else if let key = self.localizationKey {
            self.text = key.cw_localized
        }
    }
}
