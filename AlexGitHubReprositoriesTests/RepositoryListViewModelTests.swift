//
//  RepositoryListViewModelTests.swift
// Tests
//
//  Created by Alex on 02/03/2024.
//

import Foundation
import AlexGitHubReprositoriesDbApi
import XCTest
import Combine
@testable import AlexGitHubReprositories

class RepositoryListViewModelTests: XCTestCase {
    
    var api: GitHubRepositoriesDBApi!
    var viewModel: RepositoryListViewModel!
    var cancelBag: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        api = GitHubRepositoriesDBApi()
        api.setNetworkProvider(MockNetworkRequest(mockResponse: GitHubRepository.sampleString))
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RepositoryListViewModel(api: api)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        api = nil
        viewModel = nil
    }
    
    func test_loadDataWithWrongDataShouldReturnError() async throws {
        let expectation = XCTestExpectation(description: "load data is with errors is expected")
        api.setNetworkProvider(MockNetworkRequest(mockResponse: ""))

        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.state, .loading)
        
        // Simulate task completion
        try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate some asynchronous operation
        
        switch viewModel.state {
        case .failed:
            expectation.fulfill()
        default: break
        }
    }
         
    func testLoadDataSuccess() async throws {
        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.state, .loading)
        
        // Simulate task completion
        try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate some asynchronous operation
        
        switch viewModel.state {
        case .loaded(let data):
            XCTAssertEqual(data.count, 1)
            XCTAssertEqual(data.first?.author, "xingshaocheng")
            XCTAssertEqual(data.first?.name, "architect-awesome")
        default: break
        }
    }
}
