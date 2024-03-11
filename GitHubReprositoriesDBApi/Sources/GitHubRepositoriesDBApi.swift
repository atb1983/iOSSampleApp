//
//
//  Created by Alex Franco on 30/02/2024.
//

import Foundation

public class GitHubRepositoriesDBApi {
    
    private let URL_ENDPOINT = "https://gtrending.yapie.me/repositories?since=daily&spoken_language_code=en"
    
    private var networkRequestProvider: NetworkRequestProtocol = NetworkRequest()
    
    public init() {
    }
    
    public func setNetworkProvider(_ provider: NetworkRequestProtocol) {
        networkRequestProvider = provider
    }
    
    var spokenLanguageParam: URLQueryItem {
        URLQueryItem(name: "spoken_language_code", value: "en")
    }
    
    var sinceParam: URLQueryItem {
        URLQueryItem(name: "since", value: "daily")
    }
    
    var getUrlTrendingRepositories: String {
        var url = URLComponents(string: "\(URL_ENDPOINT)repositories")
        url?.queryItems = [sinceParam, spokenLanguageParam]
        return url?.url?.absoluteString ?? ""
    }
    
    // Get Trending repositories
    public func getTrendingRepositories() async throws -> GitHubRepositories {
        return try await withCheckedThrowingContinuation { continuation in
            Task {
                do {
                    let response = try await networkRequestProvider.httpGetAsString(from: getUrlTrendingRepositories)
                    guard let model = GitHubRepositoryDecoder.getTrendingRepositoriesFromJson(jsonString: response) else {
                        continuation.resume(with: .failure(NetworkError.malformedJson))
                        return
                    }
                    
                    continuation.resume(with: .success(model))
                } catch {
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    public func getImage(url: String) async throws -> Data {
        try await networkRequestProvider.httpGet(from: url)
    }
}
