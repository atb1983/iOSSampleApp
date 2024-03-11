//
//  LandingPageViewModelTests.swift
// Tests
//
//  Created by Alex on 02/03/2024.
//

import Foundation
import XCTest
@testable import AlexGitHubReprositories

class LandingPageViewModelTests: XCTestCase {
    
    var vieWModel: LandingPageViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vieWModel = LandingPageViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vieWModel = nil
    }
    
    func test_onGoToMainSite() {
        XCTAssertTrue(vieWModel.onGoToMainSite())
    }
    
    func test_onGoToPrivacy() {
        XCTAssertTrue(vieWModel.onGoToPrivacy())
    }
    
    func test_onGoToTermsOfUse() {
        XCTAssertTrue(vieWModel.onGoToTermsOfUse())
    }
    
}
