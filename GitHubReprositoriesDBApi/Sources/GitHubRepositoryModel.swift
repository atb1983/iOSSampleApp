//
//  Joke.swift
//
//  Created by Alex Franco on 30/02/2024.
//

import Foundation

public typealias GitHubRepositories = [GitHubRepository]

public struct GitHubRepository: Codable, Hashable {
    public let author, name: String?
    public let avatar: String?
    public let url: String?
    public let gitHubRepositoryDescription, language, languageColor: String?
    public let stars, forks, currentPeriodStars: Int?
    public let builtBy: [BuiltBy]?
    
    enum CodingKeys: String, CodingKey {
        case author, name, avatar, url
        case gitHubRepositoryDescription = "description"
        case language, languageColor, stars, forks, currentPeriodStars, builtBy
    }
    
    public init(author: String?, name: String?, avatar: String?, url: String?, gitHubRepositoryDescription: String?, language: String?, languageColor: String?, stars: Int?, forks: Int?, currentPeriodStars: Int?, builtBy: [BuiltBy]?) {
        self.author = author
        self.name = name
        self.avatar = avatar
        self.url = url
        self.gitHubRepositoryDescription = gitHubRepositoryDescription
        self.language = language
        self.languageColor = languageColor
        self.stars = stars
        self.forks = forks
        self.currentPeriodStars = currentPeriodStars
        self.builtBy = builtBy
    }
}

// MARK: - BuiltBy
public struct BuiltBy: Codable, Hashable {
    public let href, avatar: String?
    public let username: String?
}


public extension GitHubRepository {
    static var sample: GitHubRepository {
        GitHubRepository(author: "my author", name: "some name", avatar: "", url: "link", gitHubRepositoryDescription: "description", language: "C", languageColor: "#CCCCCC", stars: 5, forks: 10, currentPeriodStars: 10, builtBy: nil)
    }
    
    static var sampleString: String {
        """
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
    }
}
