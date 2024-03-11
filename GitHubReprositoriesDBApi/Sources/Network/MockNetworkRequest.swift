//
//  MockNetworkRequest.swift
//
//  Created by Alex Franco on 04/03/2024.
//

import Foundation

public struct MockNetworkRequest: NetworkRequestProtocol {
    
    private var mockNetworkResponse: String
    
    public init(mockResponse: String) {
        mockNetworkResponse = mockResponse
    }
    
    public func httpGet(from urlString: String) async throws -> Data {
        mockNetworkResponse.data(using: .utf8) ?? Data()
    }
    
    public func httpGetAsString(from urlString: String) async throws -> String {
        mockNetworkResponse
    }
    
}
