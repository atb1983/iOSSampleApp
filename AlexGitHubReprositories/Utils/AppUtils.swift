//
//  AppUtils.swift

//
//  Created by Alex on 30/02/2024.
//

import SwiftUI

public protocol AppUtilsProtocol {
    @discardableResult
    func open(urlString: String) -> Bool
}

public struct AppUtils: AppUtilsProtocol {        
    @discardableResult
    public func open(urlString: String) -> Bool {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
            return true
        } else {
            return false
        }
    }
}
