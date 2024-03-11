//
// GitHubRepositoriesDBApiTests.swift
// GitHubRepositoriesDBApiTests
//
//  Created by Alex Franco on 30/02/2024.
//

import XCTest
@testable import AlexGitHubReprositoriesDbApi

class GitHubRepositoriesDBApiTests: XCTestCase {

    var api: GitHubRepositoriesDBApi!
    
    override func setUpWithError() throws {
        api = GitHubRepositoriesDBApi()
    }

    override func tearDownWithError() throws {
        api = nil
    }

    func testUrlForGitHubRepositories() {
        let urlString = api.getUrlTrendingRepositories
        XCTAssertEqual("https://gtrending.yapie.me/repositories?since=daily&spoken_language_code=en", urlString)
    }
        
    func testInvalidJson() async {
        let api = GitHubRepositoriesDBApi()
        let testResponse = """
{ "type": "success", "value": { malformed json {{{ }
"""
        api.setNetworkProvider(MockNetworkRequest(mockResponse: testResponse))
        
        do {
            let repositories = try await api.getTrendingRepositories()
            XCTAssertNotNil(repositories, "this call is supposed to fail")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testJsonWithSuccess() async throws {
        let testResponse = """
[
  {
    "author": "xingshaocheng",
    "name": "architect-awesome",
    "avatar": "https://github.com/xingshaocheng.png",
    "url": "https://github.com/xingshaocheng/architect-awesome",
    "description": "后端架构师技术图谱",
    "language": "Go",
    "languageColor": "#3572A5",
    "stars": 7333,
    "forks": 1546,
    "currentPeriodStars": 1528,
    "builtBy": [
      {
        "href": "https://github.com/viatsko",
        "avatar": "https://avatars0.githubusercontent.com/u/376065",
        "username": "viatsko"
      }
    ]
  }
]
"""
        
        api.setNetworkProvider(MockNetworkRequest(mockResponse: testResponse))
        let data = try await api.getTrendingRepositories()
        XCTAssertEqual(data.first?.author, "xingshaocheng")
        XCTAssertEqual(data.count, 1)
                        
    }
    
    func testJsonWithFail() async {
        let api = GitHubRepositoriesDBApi()        
        let testResponse = """
{ } }
"""
        
        api.setNetworkProvider(MockNetworkRequest(mockResponse: testResponse))
        do {
            let repositories = try await api.getTrendingRepositories()
            XCTAssertNotNil(repositories, "this call is supposed to fail")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testMalformedUrl() async {
        do {
            let repositories = try await NetworkRequest().httpGet(from: "https://a b")
            XCTAssertNotNil(repositories, "Response cannot succeeded for malformed url!")
        } catch {
        XCTAssertNotNil(error)
        }                    
    }
}
