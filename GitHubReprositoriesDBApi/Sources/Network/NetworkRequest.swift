//
//  NetworkRequest.swift
//
//  Created by Alex Franco on 04/03/2024.
//

import Foundation

struct NetworkRequest: NetworkRequestProtocol {
    func httpGetAsString(from urlString: String) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            Task {
                do {
                    let data = try await httpGet(from: urlString)
                    let responseString = String(decoding: data, as: UTF8.self)
                    continuation.resume(with: .success(responseString))
                } catch {
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    func httpGet(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError.malformedUrl
        }
        
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        return try await withCheckedThrowingContinuation { continuation in
            let task = session.dataTask(with: urlRequest) { data, urlResponse, error in
                
                if let error = error {
                    // Error in respone
                    continuation.resume(with: .failure(error))
                    return
                }
                
                if let data = data {
                    continuation.resume(with: .success(data))
                }
            }
            
            task.resume()
        }
    }
    
}
