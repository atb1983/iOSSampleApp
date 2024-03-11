//
//  GitHubRepositoryDecoder.swift
//
//  Created by Alex Franco on 30/02/2024.
//

import Foundation

struct GitHubRepositoryDecoder {
    static private func decodeJson<T: Decodable>(jsonString: String, model: T.Type) -> T?  {
        var data: T
        
        let jsonData = Data(jsonString.utf8)
        
        do {
            data = try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
        return data
    }
        
    static public func getTrendingRepositoriesFromJson(jsonString: String) -> GitHubRepositories? {
        GitHubRepositoryDecoder.decodeJson(jsonString: jsonString, model: GitHubRepositories.self)
    }
}
