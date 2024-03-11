//
//  RepositoryDetailsViewModel.swift
// Tests
//
//  Created by Alex on 02/03/2024.
//

import Foundation
import AlexGitHubReprositoriesDbApi
import XCTest
import Combine
@testable import AlexGitHubReprositories

class RepositoryDetailsViewModelTests: XCTestCase {
    var vieWModel: RepositoryDetailsViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vieWModel = RepositoryDetailsViewModel(model: GitHubRepository.sample)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vieWModel = nil
    }
    
    func test_onOpenRepository() {
        XCTAssertTrue(vieWModel.onOpenRepository())
    }
}
