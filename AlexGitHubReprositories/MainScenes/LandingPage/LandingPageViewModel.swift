//
//  LandingPageViewModel.swift

//
//  Created by Alex on 30/02/2024.
//

import SwiftUI

class LandingPageViewModel: ObservableObject {
    let appUtils: AppUtilsProtocol
    
    init(appUtils: AppUtilsProtocol = AppUtils()) {
        self.appUtils = appUtils
    }
    
    @discardableResult
    func onGoToMainSite() -> Bool {
        appUtils.open(urlString: "https://github.com/")
    }
    
    @discardableResult
    func onGoToPrivacy() -> Bool {
        appUtils.open(urlString: "https://docs.github.com/en/site-policy/privacy-policies/github-general-privacy-statement")
    }
    
    @discardableResult
    func onGoToTermsOfUse() -> Bool {
        appUtils.open(urlString: "https://docs.github.com/en/site-policy/github-terms/github-terms-of-service")
    }
}
